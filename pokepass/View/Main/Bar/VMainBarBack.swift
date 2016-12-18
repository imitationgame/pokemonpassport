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
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        
        let button:UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named:"genericBack"), for:UIControlState())
        button.imageView?.contentMode = UIViewContentMode.center
        button.imageView?.clipsToBounds = true
        button.imageEdgeInsets = UIEdgeInsetsMake(20, 0, 0, 25)
        button.addTarget(self, action:#selector(self.actionBack(sender:)), for:UIControlEvents.touchUpInside)
        self.button = button
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.bold(15)
        label.textColor = UIColor.white
        self.label = label
        
        addSubview(button)
        addSubview(label)
        
        let views:[String:UIView] = [
            "button":button,
            "label":label]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[button(65)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[button]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[label]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-20-[label(44)]",
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
