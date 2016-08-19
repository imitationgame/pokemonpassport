import UIKit

class CCreate:CMainController
{
    weak var viewCreate:VCreate!
    let model:MCreate
    private var project:DPokePassProject?
    private var storeLocations:[MCreateAnnotation]?
    
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
            viewCreate.map.regenerateRoute()
        }
    }
    
    func addLocation()
    {
        let annotation:MCreateAnnotation = viewCreate.map.coordinatesAtCenter()
        model.locations.append(annotation)
        viewCreate.map.addAnnotation(annotation)
        viewCreate.map.regenerateRoute()
    }
    
    func removeLast()
    {
        if !model.locations.isEmpty
        {
            let annotation:MCreateAnnotation = model.locations.removeLast()
            viewCreate.map.removeAnnotation(annotation)
            viewCreate.map.regenerateRoute()
        }
    }
    
    func removeLocation(location:MCreateAnnotation)
    {
        let countLocations:Int = model.locations.count
        var index:Int = 0
        
        for inIndex:Int in 0 ..< countLocations
        {
            let inLocation:MCreateAnnotation = model.locations[inIndex]
            
            if inLocation === location
            {
                index = inIndex
                
                break
            }
        }
        
        model.locations.removeAtIndex(index)
        viewCreate.map.removeAnnotation(location)
        viewCreate.map.regenerateRoute()
    }
    
    func moveLocation(location:MCreateAnnotation)
    {
        viewCreate.pointer.showMoving()
        viewCreate.map.removeAnnotation(location)
    }
}