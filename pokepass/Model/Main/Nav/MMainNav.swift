import Foundation

class MMainNav
{
    let items:[MMainNavItem]
    weak var current:MMainNavItem!
    
    init()
    {
        var items:[MMainNavItem] = []
        let itemSettings:MMainNavItem = MMainNavItemSettings(items.count)
        items.append(itemSettings)
        let itemProjects:MMainNavItem = MMainNavItemProjects(items.count)
        items.append(itemProjects)
        let itemCreate:MMainNavItem = MMainNavItemCreate(items.count)
        items.append(itemCreate)
        self.items = items
        selectItem(itemProjects)
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
            
            item.restate(state)
        }
    }
}
