import UIKit

class MMainNavItemStateNone:MMainNavItemState
{
    fileprivate let kSelectable:Bool = true
    fileprivate let kHighlightable:Bool = true
    
    init()
    {
        let color:UIColor = UIColor(white:1, alpha:0.4)
        
        super.init(color:color, selectable:kSelectable, highlightable:kHighlightable)
    }
}
