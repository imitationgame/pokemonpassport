import UIKit

class VSettingsCellMetrics:VSettingsCell
{
    weak var segmented:UISegmentedControl!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let label:UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clearColor()
        label.userInteractionEnabled = false
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.bold(14)
        label.textColor = UIColor.main()
        label.text = NSLocalizedString("VSettingsCellMetrics_label", comment:"")
        
        let segmented:UISegmentedControl = UISegmentedControl(items:items)
        
        addSubview(label)
        
        let views:[String:AnyObject] = [
            "label":label]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[label]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-10-[label(20)]",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}