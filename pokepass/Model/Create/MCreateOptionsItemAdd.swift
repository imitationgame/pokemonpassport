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
        print(controller.viewCreate.map.coordinatesAtCenter())
    }
}