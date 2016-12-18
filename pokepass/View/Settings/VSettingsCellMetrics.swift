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
        label.backgroundColor = UIColor.clear
        label.isUserInteractionEnabled = false
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.bold(size:14)
        label.textColor = UIColor.main.withAlphaComponent(0.7)
        label.text = NSLocalizedString("VSettingsCellMetrics_label", comment:"")
        
        let segmented:UISegmentedControl = UISegmentedControl()
        segmented.translatesAutoresizingMaskIntoConstraints = false
        segmented.tintColor = UIColor.main
        self.segmented = segmented
        
        addSubview(label)
        addSubview(segmented)
        
        let views:[String:UIView] = [
            "label":label,
            "segmented":segmented]
        
        let metrics:[String:CGFloat] = [
            "segmentedWidth":kSegmentedWidth,
            "segmentedHeight":kSegmentedHeight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[label]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[segmented(segmentedWidth)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-5-[label(20)]-5-[segmented(segmentedHeight)]",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutSegmentedLeft = NSLayoutConstraint(
            item:segmented,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
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
