import Foundation

class MMainNav
{
    let items:[MMainNavItem]
    weak var current:MMainNavItem!
    
    init()
    {
        var items:[MMainNavItem] = []
        let itemProfile:MMainNavItem = MMainNavItem.Profile(items.count)
        items.append(itemProfile)
        let itemLiked:MMainNavItem = MMainNavItem.Liked(items.count)
        items.append(itemLiked)
        let itemHome:MMainNavItem = MMainNavItem.Home(items.count)
        items.append(itemHome)
        let itemCreate:MMainNavItem = MMainNavItem.Create(items.count)
        items.append(itemCreate)
        let itemNotifications:MMainNavItem = MMainNavItem.Notifications(items.count)
        items.append(itemNotifications)
        
        #if DEBUG
            
            let itemRoot:MMainNavItem = MMainNavItem.Root(items.count)
            items.append(itemRoot)
            
        #endif
        
        self.items = items
        selectItem(itemHome)
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