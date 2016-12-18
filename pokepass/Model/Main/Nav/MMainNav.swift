import Foundation

class MMainNav
{
    let items:[MMainNavItem]
    weak var current:MMainNavItem!
    
    init()
    {
        var items:[MMainNavItem] = []
        let itemSettings:MMainNavItem = MMainNavItemSettings(index:items.count)
        items.append(itemSettings)
        let itemProjects:MMainNavItem = MMainNavItemProjects(index:items.count)
        items.append(itemProjects)
        self.items = items
        selectItem(selected:itemProjects)
    }
    
    //MARK: public
    
    func selectItem(selected:MMainNavItem)
    {
        current = selected
        
        for item:MMainNavItem in items
        {
            let state:MMainNavItemState
            
            if item === selected
            {
                state = MMainNavItemStateActive()
            }
            else
            {
                state = MMainNavItemStateNone()
            }
            
            item.restate(state:state)
        }
    }
}
