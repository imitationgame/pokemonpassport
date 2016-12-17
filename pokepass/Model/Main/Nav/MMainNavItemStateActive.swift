import UIKit

class MMainNavItemStateActive:MMainNavItemState
{
    fileprivate let kSelectable:Bool = false
    fileprivate let kHighlightable:Bool = false
    
    init()
    {
        let color:UIColor = UIColor.complement()
        
        super.init(color:color, selectable:kSelectable, highlightable:kHighlightable)
    }
}
