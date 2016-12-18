import Foundation

class MCreateOptions
{
    let items:[MCreateOptionsItem]
    
    init()
    {
        let itemClear:MCreateOptionsItemClear = MCreateOptionsItemClear()
        let itemSave:MCreateOptionsItemSave = MCreateOptionsItemSave()
        
        items = [
            itemClear,
            itemSave
        ]
    }
}
