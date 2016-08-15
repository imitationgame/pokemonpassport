import Foundation

class MCreateOptionsItemClear:MCreateOptionsItem
{
    private let kImage:String = "optionsClear"
    
    init()
    {
        let title:String = NSLocalizedString("MCreateOptionsItemClear_title", comment:"")
        super.init(image:kImage, title:title)
    }
    
    override func selected(controller:CCreate)
    {
        controller.clear()
    }
}