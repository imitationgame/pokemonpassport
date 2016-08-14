import UIKit

class MMainNavItemStateNone:MMainNavItemState
{
    private let kSelectable:Bool = true
    private let kHighlightable:Bool = true
    
    init()
    {
        let color:UIColor = UIColor(white:1, alpha:0.4)
        
        super.init(color:color, selectable:kSelectable, highlightable:kHighlightable)
    }
}