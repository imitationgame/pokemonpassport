import Foundation

class MCreateOptions
{
    let items:[MCreateOptionsItem]
    
    init()
    {
        let itemClear:MCreateOptionsItemClear = MCreateOptionsItem.Clear()
        let itemSave:MCreateOptionsItemSave = MCreateOptionsItem.Save()
        
        items = [
            itemClear,
            itemSave
        ]
    }
}