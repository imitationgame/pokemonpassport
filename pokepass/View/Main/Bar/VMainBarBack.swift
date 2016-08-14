import UIKit

class VMainBarBack:UIView
{
    weak var main:CMainParent!
    weak var button:UIButton!
    weak var label:UILabel!
    
    convenience init(main:CMainParent)
    {
        self.init()
        self.main = main
        clipsToBounds = true
        backgroundColor = UIColor.clearColor()
        translatesAutoresizingMaskIntoConstraints = false
        
        let button:UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named:"genericBack"), forState:UIControlState.Normal)
        button.imageView?.contentMode = UIViewContentMode.Center
        button.imageView?.clipsToBounds = true
        button.imageEdgeInsets = UIEdgeInsetsMake(20, 0, 0, 25)
        button.addTarget(self, action:#selector(self.actionBack(sender:)), forControlEvents:UIControlEvents.TouchUpInside)
        self.button = button
        
        let label:UILabel = UILabel()
        label.userInteractionEnabled = false
        label.backgroundColor = UIColor.clearColor()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.bold(15)
        label.textColor = UIColor.whiteColor()
        self.label = label
        
        addSubview(button)
        addSubview(label)
        
        let views:[String:AnyObject] = [
            "button":button,
            "label":label]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[button(65)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[button]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[label]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-20-[label(44)]",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    //MARK: actions
    
    func actionBack(sender button:UIButton)
    {
        main.backController()
    }
}