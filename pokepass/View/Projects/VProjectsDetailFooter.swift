import UIKit

class VProjectsDetailFooter:UICollectionReusableView
{
    weak var controller:CProjectsDetail!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clearColor()
        
        let label:UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.userInteractionEnabled = false
        label.backgroundColor = UIColor.clearColor()
        label.font = UIFont.bold(12)
        label.textColor = UIColor.main()
        label.textAlignment = NSTextAlignment.Center
        label.numberOfLines = 0
        label.text = NSLocalizedString("VProjectsDetailFooter_label", comment:"")
        
        let button:UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named:"share"), forState:UIControlState.Normal)
        button.imageView?.contentMode = UIViewContentMode.Center
        button.imageView?.clipsToBounds = true
        button.addTarget(self, action:#selector(self.actionShare(sender:)), forControlEvents:UIControlEvents.TouchUpInside)
        
        addSubview(label)
        addSubview(button)
        
        let views:[String:AnyObject] = [
            "label":label,
            "button":button]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-10-[label]-10-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-100-[button]-100-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[button(80)]-15-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[label(20)]-(-25)-[button]",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: actions
    
    func actionShare(sender button:UIButton)
    {
        button.userInteractionEnabled = false
        controller.share()
    }
    
    //MARK: public
    
    func config(controller:CProjectsDetail)
    {
        self.controller = controller
    }
}