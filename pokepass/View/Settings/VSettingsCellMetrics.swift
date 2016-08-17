import UIKit

class VSettingsCellMetrics:VSettingsCell
{
    weak var segmented:UISegmentedControl!
    weak var layoutSegmentedLeft:NSLayoutConstraint!
    private let kSegmentedWidth:CGFloat = 250
    private let kSegmentedHeight:CGFloat = 32
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let label:UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clearColor()
        label.userInteractionEnabled = false
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.bold(14)
        label.textColor = UIColor.main().colorWithAlphaComponent(0.7)
        label.text = NSLocalizedString("VSettingsCellMetrics_label", comment:"")
        
        let segmented:UISegmentedControl = UISegmentedControl()
        segmented.translatesAutoresizingMaskIntoConstraints = false
        segmented.tintColor = UIColor.main()
        self.segmented = segmented
        
        addSubview(label)
        addSubview(segmented)
        
        let views:[String:AnyObject] = [
            "label":label,
            "segmented":segmented]
        
        let metrics:[String:AnyObject] = [
            "segmentedWidth":kSegmentedWidth,
            "segmentedHeight":kSegmentedHeight]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[label]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:[segmented(segmentedWidth)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-5-[label(20)]-5-[segmented(segmentedHeight)]",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutSegmentedLeft = NSLayoutConstraint(
            item:segmented,
            attribute:NSLayoutAttribute.Left,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Left,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutSegmentedLeft)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let remain:CGFloat = width - kSegmentedWidth
        let margin:CGFloat = remain / 2
        layoutSegmentedLeft.constant = margin
        
        super.layoutSubviews()
    }
}