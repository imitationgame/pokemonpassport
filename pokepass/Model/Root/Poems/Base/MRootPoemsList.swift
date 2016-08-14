import Foundation

class MRootPoemsList
{
    let state:MRootPoemsState
    var items:[MRootPoemsListItem]
    
    init(state:MRootPoemsState)
    {
        self.state = state
        items = []
    }
    
    //MARK: public
    
    func add(item:MRootPoemsListItem)
    {
        var index:Int = 0
        
        for inItem:MRootPoemsListItem in items
        {
            if inItem.lastEdit > item.lastEdit
            {
                break
            }
            
            index += 1
        }
        
        items.insert(item, atIndex:index)
    }
    
    func controller() -> CRootList
    {
        let list:CRootList = state.controllerType.init(model:self)
        
        return list
    }
}