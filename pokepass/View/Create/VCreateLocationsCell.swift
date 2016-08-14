import UIKit

class VCreateLocationsCell:UICollectionViewCell
{
    override init(frame:CGRect)
    {
        super.init(frame:CGRectZero)
        clipsToBounds = true
        backgroundColor = UIColor.clearColor()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}