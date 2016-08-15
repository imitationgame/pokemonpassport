import Foundation

class MCreateOptionsItemRemoveLast:MCreateOptionsItem
{
    private let kImage:String = "optionsRemoveLast"
    
    init()
    {
        let title:String = NSLocalizedString("MCreateOptionsItemRemoveLast_title", comment:"")
        super.init(image:kImage, title:title)
    }
    
    override func selected(controller:CCreate)
    {
        controller.removeLast()
    }
}