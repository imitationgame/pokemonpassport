import Foundation

class MMainNav
{
    let items:[MMainNavItem]
    weak var current:MMainNavItem!
    
    init()
    {
        var items:[MMainNavItem] = []
        let itemSettings:MMainNavItem = MMainNavItem.Settings(items.count)
        items.append(itemSettings)
        let itemProjects:MMainNavItem = MMainNavItem.Projects(items.count)
        items.append(itemProjects)
        let itemCreate:MMainNavItem = MMainNavItem.Create(items.count)
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
                state = MMainNavItemState.Active()
            }
            else
            {
                state = MMainNavItemState.None()
            }
            
            item.restate(state)
        }
    }
}