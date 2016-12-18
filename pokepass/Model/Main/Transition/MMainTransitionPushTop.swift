import UIKit

class MMainTransitionPushTop:MMainTransition
{
    private let kAnimationDuration:TimeInterval = 0.5
    
    init()
    {
        super.init(animationDuration:kAnimationDuration)
    }
    
    override func positionBefore()
    {
        let width:CGFloat = current!.view.bounds.maxX
        let shadow:VMainShadow = VMainShadow()
        
        parent.layoutTopTemporal = NSLayoutConstraint(
            item:next.view,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:parent.view,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:0)
        parent.layoutBottomTemporal = NSLayoutConstraint(
            item:next.view,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:parent.view,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        parent.layoutLeftTemporal = NSLayoutConstraint(
            item:next.view,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:parent.view,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:width)
        parent.layoutRightTemporal = NSLayoutConstraint(
            item:next.view,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:parent.view,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:width)
        
        parent.view.addConstraint(parent.layoutLeftTemporal!)
        parent.view.addConstraint(parent.layoutRightTemporal!)
        parent.view.addConstraint(parent.layoutTopTemporal!)
        parent.view.addConstraint(parent.layoutBottomTemporal!)
        
        parent.shadow = shadow
        current?.view.addSubview(shadow)
        
        let views:[String:AnyObject] = [
            "shadow":shadow]
        
        let metrics:[String:AnyObject] = [:]
        
        current?.view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[shadow]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        current?.view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[shadow]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    override func animationBefore()
    {
        parent.view.layoutIfNeeded()
    }
    
    override func positionAfter()
    {
        let width:CGFloat = current!.view.bounds.maxX / -2.0
        parent.layoutLeft!.constant = width
        parent.layoutRight!.constant = width
        parent.layoutLeftTemporal!.constant = 0
        parent.layoutRightTemporal!.constant = 0
    }
    
    override func animationAfter()
    {
        parent.view.layoutIfNeeded()
        parent.shadow?.alpha = 1
    }
    
    override func completed()
    {
        parent.previous = parent.current
    }
}
