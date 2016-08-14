import UIKit

class MMainNavItemState
{
    let color:UIColor
    let selectable:Bool
    let highlightable:Bool
    
    class func None() -> MMainNavItemState
    {
        let state:MMainNavItemState = MMainNavItemStateNone()
        
        return state
    }
    
    class func Active() -> MMainNavItemState
    {
        let state:MMainNavItemState = MMainNavItemStateActive()
        
        return state
    }
    
    init(color:UIColor, selectable:Bool, highlightable:Bool)
    {
        self.color = color
        self.selectable = selectable
        self.highlightable = highlightable
    }
}