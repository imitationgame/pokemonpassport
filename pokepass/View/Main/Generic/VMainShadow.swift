import UIKit

class VMainShadow:UIView
{
    init()
    {
        super.init(frame:CGRectZero)
        clipsToBounds = true
        backgroundColor = UIColor.clearColor()
        userInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        alpha = 0
        
        let visualEffect:UIVisualEffect = UIBlurEffect(style:UIBlurEffectStyle.Dark)
        let blur:UIVisualEffectView = UIVisualEffectView(effect:visualEffect)
        blur.translatesAutoresizingMaskIntoConstraints = false
        blur.userInteractionEnabled = false
        blur.clipsToBounds = true
        
        addSubview(blur)
        
        let views:[String:AnyObject] = [
            "blur":blur]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[blur]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[blur]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
