import UIKit

class VProjectsHeader:UICollectionReusableView
{
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.complement()
        userInteractionEnabled = false
        
        let label:UILabel = UILabel()
        label.userInteractionEnabled = false
        label.backgroundColor = UIColor.clearColor()
        label.font = UIFont.regular(15)
        label.textColor = UIColor.blackColor()
        label.textAlignment = NSTextAlignment.Center
        label.numberOfLines = 0
        label.text = NSLocalizedString("VProjectsHeader_label", comment:"")
        
        addSubview(label)
        
        let views:[String:AnyObject] = [
            "label":label]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-20-[label]-20-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[label]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}