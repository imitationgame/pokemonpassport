import Foundation

class MCreateOptions
{
    let items:[MCreateOptionsItem]
    
    init()
    {
        let itemAdd:MCreateOptionsItemAdd = MCreateOptionsItem.Add()
        let itemRemoveLast:MCreateOptionsItemRemoveLast = MCreateOptionsItem.RemoveLast()
        let itemClear:MCreateOptionsItemClear = MCreateOptionsItem.Clear()
        let itemSave:MCreateOptionsItemSave = MCreateOptionsItem.Save()
        
        items = [
            itemAdd,
            itemRemoveLast,
            itemClear,
            itemSave
        ]
    }
}