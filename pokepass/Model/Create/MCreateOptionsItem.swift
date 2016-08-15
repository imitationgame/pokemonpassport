import UIKit

class MCreateOptionsItem
{
    let image:String
    let title:String
    
    class func Save() -> MCreateOptionsItemSave
    {
        let model:MCreateOptionsItemSave = MCreateOptionsItemSave()
        
        return model
    }
    
    class func Clear() -> MCreateOptionsItemClear
    {
        let model:MCreateOptionsItemClear = MCreateOptionsItemClear()
        
        return model
    }
    
    class func RemoveLast() -> MCreateOptionsItemRemoveLast
    {
        let model:MCreateOptionsItemRemoveLast = MCreateOptionsItemRemoveLast()
        
        return model
    }
    
    class func Add() -> MCreateOptionsItemAdd
    {
        let model:MCreateOptionsItemAdd = MCreateOptionsItemAdd()
        
        return model
    }
    
    init(image:String, title:String)
    {
        self.image = image
        self.title = title
    }
    
    //MARK: public
    
    func config(cell:VCreateOptionsCell)
    {
        cell.label.text = title
        cell.image.image = UIImage(named:image)
    }
    
    func selected(controller:CCreate)
    {
    }
}