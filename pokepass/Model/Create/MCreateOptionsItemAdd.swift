import Foundation

class MCreateOptionsItemAdd:MCreateOptionsItem
{
    private let kImage:String = "optionsAdd"
    
    init()
    {
        let title:String = NSLocalizedString("MCreateOptionsItemAdd_title", comment:"")
        super.init(image:kImage, title:title)
    }
    
    override func selected(controller:CCreate)
    {
        let annotation:MCreateAnnotation = controller.viewCreate.map.coordinatesAtCenter()
        controller.model.locations.append(annotation)
        controller.viewCreate.map.addAnnotation(annotation)
        
    }
}