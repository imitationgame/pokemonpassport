import UIKit

class MMainNavItemState
{
    let color:UIColor
    let selectable:Bool
    let highlightable:Bool

    init(color:UIColor, selectable:Bool, highlightable:Bool)
    {
        self.color = color
        self.selectable = selectable
        self.highlightable = highlightable
    }
}
