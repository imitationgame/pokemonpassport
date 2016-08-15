import UIKit

class CCreate:CMainController
{
    weak var viewCreate:VCreate!
    let model:MCreate
    private var project:DPokePassProject?
    
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
        for item:DPokePassLocation in project!.projectLocations
        {
            print("lat:\(item.latitude) lon:\(item.longitude)")
        }
        
        DManager.sharedInstance.managerPokePass.saver.save(false)
        project = nil
        VMainAlert.Message(NSLocalizedString("CMainController_saved", comment:""))
        
        dispatch_async(dispatch_get_main_queue())
        { [weak self] in
            
            self?.viewCreate.restart()
        }
    }
    
    private func storeRoute()
    {
        if model.locations.isEmpty
        {
            finishStoring()
        }
        else
        {
            let annotation:MCreateAnnotation = model.locations.removeFirst()
            let latitude:Double = annotation.coordinate.latitude
            let longitude:Double = annotation.coordinate.longitude
            
            DManager.sharedInstance.managerPokePass.createManagedObject(
                DPokePassLocation.self)
            { [weak self] (model) in
                
                model.latitude = latitude
                model.longitude = longitude
                model.locationProject = self?.project
                self?.storeRoute()
            }
        }
    }
    
    private func storeProject()
    {
        DManager.sharedInstance.managerPokePass.createManagedObject(
            DPokePassProject.self)
        { [weak self] (model) in
            
            self?.project = model
            self?.storeRoute()
        }
    }
    
    //MARK: public
    
    func save(name:String)
    {
        viewCreate.showLoading()
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0))
        { [weak self] in
        
            self?.storeProject()
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
}