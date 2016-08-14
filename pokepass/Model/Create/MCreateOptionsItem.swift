import Foundation

class MCreateOptionsItem
{
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
}