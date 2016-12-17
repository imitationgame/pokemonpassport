import UIKit

class CCreate:CMainController
{
    weak var viewCreate:VCreate!
    let model:MCreate
    fileprivate var project:DPokePassProject?
    fileprivate var storeLocations:[MCreateAnnotation]?
    fileprivate let kShutterTimeout:UInt64 = 250
    fileprivate weak var movingAnnotation:MCreateAnnotation?
    
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
    
    fileprivate func finishStoring()
    {
        DManager.sharedInstance.managerPokePass.saver.save(false)
        project = nil
        VMainAlert.Message(NSLocalizedString("CMainController_saved", comment:""))
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.clear()
            self?.viewCreate.hideLoading()
        }
    }
    
    fileprivate func storeRoute()
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
    
    fileprivate func storeProject(_ name:String)
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
    
    fileprivate func regenerateRoute()
    {
        let countLocations:Int = model.locations.count
        
        for index:Int in 0 ..< countLocations
        {
            let location:MCreateAnnotation = model.locations[index]
            location.index = index
        }
        
        viewCreate.map.regenerateRoute()
    }
    
    fileprivate func beforeAddLocation(_ location:MCreateAnnotation)
    {
        viewCreate.map.addAnnotation(location)
        regenerateRoute()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(NSEC_PER_MSEC * kShutterTimeout)) / Double(NSEC_PER_SEC))
        { [weak self] in
            
            self?.afterAddLocation()
        }
    }
    
    fileprivate func afterAddLocation()
    {
        viewCreate.pointer.showPointer()
        viewCreate.button.isHidden = false
    }
    
    //MARK: public
    
    func save(_ name:String)
    {
        viewCreate.showLoading()
        
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.background).async
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
        }
        
        beforeAddLocation(annotation)
    }
    
    func removeLocation(_ location:MCreateAnnotation)
    {
        model.locations.remove(at: location.index)
        viewCreate.map.removeAnnotation(location)
        regenerateRoute()
    }
    
    func moveLocation(_ location:MCreateAnnotation)
    {
        movingAnnotation = location
        viewCreate.pointer.showMoving()
        viewCreate.map.removeAnnotation(location)
        viewCreate.map.clearRoute()
    }
}
