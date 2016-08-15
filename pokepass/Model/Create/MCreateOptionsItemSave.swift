import Foundation

class MCreateOptionsItemSave:MCreateOptionsItem
{
    private let kImage:String = "optionsSave"
    
    init()
    {
        let title:String = NSLocalizedString("MCreateOptionsItemSave_title", comment:"")
        super.init(image:kImage, title:title)
    }
}