import UIKit

class MMainNavItemStateActive:MMainNavItemState
{
    private let kSelectable:Bool = false
    private let kHighlightable:Bool = false
    
    init()
    {
        let color:UIColor = UIColor.complement()
        
        super.init(color:color, selectable:kSelectable, highlightable:kHighlightable)
    }
}