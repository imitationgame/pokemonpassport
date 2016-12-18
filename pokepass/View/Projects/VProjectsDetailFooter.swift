import UIKit

class VProjectsDetailFooter:UICollectionReusableView
{
    weak var controller:CProjectsDetail!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let label:UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.bold(size:12)
        label.textColor = UIColor.main
        label.textAlignment = NSTextAlignment.center
        label.numberOfLines = 0
        label.text = NSLocalizedString("VProjectsDetailFooter_label", comment:"")
        
        let button:UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named:"share"), for:UIControlState())
        button.imageView?.contentMode = UIViewContentMode.center
        button.imageView?.clipsToBounds = true
        button.addTarget(self, action:#selector(self.actionShare(sender:)), for:UIControlEvents.touchUpInside)
        
        addSubview(label)
        addSubview(button)
        
        let views:[String:UIView] = [
            "label":label,
            "button":button]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[label]-10-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-100-[button]-100-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[button(80)]-15-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[label(20)]-(-25)-[button]",
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
        button.isUserInteractionEnabled = false
        controller.share()
    }
    
    //MARK: public
    
    func config(controller:CProjectsDetail)
    {
        self.controller = controller
    }
}
