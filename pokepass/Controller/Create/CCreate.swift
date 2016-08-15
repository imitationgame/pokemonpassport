import UIKit

class CCreate:CMainController
{
    weak var viewCreate:VCreate!
    let model:MCreate
    
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
        
    }
    
    private func storeRoute()
    {
        if model.locations.isEmpty
        {
            
        }
        else
        {
            
        }
    }
    
    private func storeProject()
    {
        DManager.sharedInstance
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