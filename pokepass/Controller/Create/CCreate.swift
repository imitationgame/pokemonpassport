import UIKit

class CCreate:CMainController
{
    weak var viewCreate:VCreate!
    weak var movingAnnotation:MCreateAnnotation?
    weak var loadedProject:MProjectsItem?
    let model:MCreate
    private var project:DObjectProject?
    private var storeLocations:[MCreateAnnotation]?
    private let kShutterTimeout:TimeInterval = 0.25
    
    init()
    {
        model = MCreate()
        
        super.init(nibName:nil, bundle:nil)
    }
    
    init(project:MProjectsItem)
    {
        self.loadedProject = project
        model = MCreate()
        
        super.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let loadedProject:MProjectsItem = self.loadedProject
        {
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            { [weak self] in
                
                self?.model.load(project:loadedProject)
                
                DispatchQueue.main.async
                { [weak self] in
                    
                    self?.addAllAnnotations()
                }
            }
        }
    }
    
    override func loadView()
    {
        let viewCreate:VCreate = VCreate(controller:self)
        self.viewCreate = viewCreate
        view = viewCreate
    }
    
    //MARK: private
    
    private func addAllAnnotations()
    {
        viewCreate.map.addAnnotations(model.locations)
        viewCreate.history.refresh()
        regenerateRoute()
    }
    
    private func finishStoring()
    {
        DManager.sharedInstance.save()
        project = nil
        VMainAlert.Message(message:
            NSLocalizedString("CMainController_saved", comment:""))
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.clear()
            self?.viewCreate.hideLoading()
        }
    }
    
    private func storeRoute()
    {
        if storeLocations!.isEmpty
        {
            finishStoring()
        }
        else
        {
            let annotation:MCreateAnnotation = storeLocations!.removeFirst()
            let latitude:Double = annotation.coordinate.latitude
            let longitude:Double = annotation.coordinate.longitude
            
            DManager.sharedInstance.createManagedObject(
                modelType:DObjectLocation.self)
            { [weak self] (modelLocation:DObjectLocation) in
                
                modelLocation.latitude = latitude
                modelLocation.longitude = longitude
                modelLocation.locationProject = self?.project
                self?.storeRoute()
            }
        }
    }
    
    private func storeProject(name:String)
    {
        storeLocations = model.locations
        
        DManager.sharedInstance.createManagedObject(
            modelType:DObjectProject.self)
        { [weak self] (modelProject:DObjectProject) in
            
            modelProject.name = name
            self?.project = modelProject
            self?.storeRoute()
        }
    }
    
    private func regenerateRoute()
    {
        let countLocations:Int = model.locations.count
        
        for index:Int in 0 ..< countLocations
        {
            let location:MCreateAnnotation = model.locations[index]
            location.index = index
        }
        
        viewCreate.map.regenerateRoute()
        viewCreate.history.refresh()
    }
    
    private func beforeAddLocation(location:MCreateAnnotation)
    {
        viewCreate.map.addAnnotation(location)
        regenerateRoute()
        
        DispatchQueue.main.asyncAfter(
            deadline:DispatchTime.now() + kShutterTimeout)
        { [weak self] in
            
            self?.afterAddLocation()
        }
    }
    
    private func afterAddLocation()
    {
        viewCreate.pointer.showPointer()
        viewCreate.button.isHidden = false
    }
    
    //MARK: public
    
    func back()
    {
        parentController.backController()
    }
    
    func update()
    {
        viewCreate.showLoading()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).sync
        { [weak self] in
            
            self?.storeLocations = self?.model.locations
            self?.project = self?.loadedProject?.model
            self?.project?.projectLocations = NSOrderedSet()
            self?.storeRoute()
        }
    }
    
    func save(name:String)
    {
        viewCreate.showLoading()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).sync
        { [weak self] in
        
            self?.storeProject(name:name)
        }
    }
    
    func clear()
    {
        if !model.locations.isEmpty
        {
            movingAnnotation = nil
            viewCreate.map.removeAnnotations(model.locations)
            model.locations.removeAll()
            regenerateRoute()
            viewCreate.pointer.showPointer()
        }
    }
    
    func addLocation()
    {
        viewCreate.pointer.showShutter()
        viewCreate.button.isHidden = true
        
        let annotation:MCreateAnnotation
        
        if movingAnnotation == nil
        {
            annotation = viewCreate.map.annotationAtCenter()
            model.locations.append(annotation)
        }
        else
        {
            annotation = movingAnnotation!
            annotation.coordinate = viewCreate.map.coordinatesAtCenter()
            movingAnnotation = nil
        }
        
        beforeAddLocation(location:annotation)
    }
    
    func cancelMove()
    {
        if let movingAnnotation:MCreateAnnotation = self.movingAnnotation
        {
            self.movingAnnotation = nil
            viewCreate.map.addAnnotation(movingAnnotation)
            regenerateRoute()
            viewCreate.pointer.showPointer()
        }
    }
    
    func removeLocation(location:MCreateAnnotation)
    {
        model.locations.remove(at:location.index)
        viewCreate.map.removeAnnotation(location)
        regenerateRoute()
    }
    
    func moveLocation(location:MCreateAnnotation)
    {
        movingAnnotation = location
        viewCreate.pointer.showMoving()
        viewCreate.map.removeAnnotation(location)
        viewCreate.map.clearRoute()
    }
}
