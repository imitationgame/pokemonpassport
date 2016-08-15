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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView()
    {
        let viewCreate:VCreate = VCreate(controller:self)
        self.viewCreate = viewCreate
        view = viewCreate
    }
    
    //MARK: public
    
    func save(name:String)
    {
        //TODO
    }
    
    func clear()
    {
        viewCreate.map.removeAnnotations(model.locations)
        model.locations.removeAll()
    }
    
    func addLocation()
    {
        let annotation:MCreateAnnotation = viewCreate.map.coordinatesAtCenter()
        model.locations.append(annotation)
        viewCreate.map.addAnnotation(annotation)
    }
}