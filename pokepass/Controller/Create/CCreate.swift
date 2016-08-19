import UIKit

class CCreate:CMainController
{
    weak var viewCreate:VCreate!
    let model:MCreate
    private var project:DPokePassProject?
    private var storeLocations:[MCreateAnnotation]?
    private let kShutterTimeout:UInt64 = 250
    private weak var movingAnnotation:MCreateAnnotation?
    
    init()
    {
        model = MCreate()
        
        super.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func loadView()
    {
        let viewCreate:VCreate = VCreate(controller:self)
        self.viewCreate = viewCreate
        view = viewCreate
    }
    
    //MARK: private
    
    private func finishStoring()
    {
        DManager.sharedInstance.managerPokePass.saver.save(false)
        project = nil
        VMainAlert.Message(NSLocalizedString("CMainController_saved", comment:""))
        
        dispatch_async(dispatch_get_main_queue())
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
            
            DManager.sharedInstance.managerPokePass.createManagedObject(
                DPokePassLocation.self)
            { [weak self] (modelLocation) in
                
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
        
        DManager.sharedInstance.managerPokePass.createManagedObject(
            DPokePassProject.self)
        { [weak self] (modelProject) in
            
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
    }
    
    private func beforeAddLocation(location:MCreateAnnotation)
    {
        viewCreate.map.addAnnotation(location)
        regenerateRoute()
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_MSEC * kShutterTimeout)),
                       dispatch_get_main_queue())
        { [weak self] in
            
            self?.afterAddLocation()
        }
    }
    
    private func afterAddLocation()
    {
        viewCreate.pointer.showPointer()
        viewCreate.button.hidden = false
    }
    
    //MARK: public
    
    func save(name:String)
    {
        viewCreate.showLoading()
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0))
        { [weak self] in
        
            self?.storeProject(name)
        }
    }
    
    func clear()
    {
        if !model.locations.isEmpty
        {
            viewCreate.map.removeAnnotations(model.locations)
            model.locations.removeAll()
            regenerateRoute()
        }
    }
    
    func addLocation()
    {
        viewCreate.pointer.showShutter()
        viewCreate.button.hidden = true
        
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
        }
        
        beforeAddLocation(annotation)
    }
    
    func removeLocation(location:MCreateAnnotation)
    {
        model.locations.removeAtIndex(location.index)
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