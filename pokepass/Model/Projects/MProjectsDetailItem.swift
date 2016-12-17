import UIKit

class MProjectsDetailItem
{
    let reusableIdentifier:String
    let cellHeight:CGFloat
    let selectable:Bool
    
    init(reusableIdentifier:String, cellHeight:CGFloat, selectable:Bool)
    {
        self.reusableIdentifier = reusableIdentifier
        self.cellHeight = cellHeight
        self.selectable = selectable
    }
    
    //MARK: public
    
    func config(_ cell:VProjectsDetailCell, controller:CProjectsDetail)
    {
    }
    
    func selected(_ controller:CProjectsDetail)
    {
    }
}
