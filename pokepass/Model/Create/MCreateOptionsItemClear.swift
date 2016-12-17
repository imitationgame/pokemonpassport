import Foundation

class MCreateOptionsItemClear:MCreateOptionsItem
{
    fileprivate let kImage:String = "optionsClear"
    
    init()
    {
        let title:String = NSLocalizedString("MCreateOptionsItemClear_title", comment:"")
        super.init(image:kImage, title:title)
    }
    
    override func selected(_ controller:CCreate)
    {
        controller.clear()
    }
}
