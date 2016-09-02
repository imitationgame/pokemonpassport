import UIKit

class VSettingsCell:UICollectionViewCell
{
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor(white:1, alpha:0.2)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}