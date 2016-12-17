import UIKit

class MMainTransitionFade:MMainTransition
{
    fileprivate let kAnimationDuration:TimeInterval = 0.3
    
    init()
    {
        super.init(animationDuration:kAnimationDuration)
    }
    
    override func positionBefore()
    {
        let barHeight:CGFloat
        
        if parent.bar == nil
        {
            barHeight = 0
        }
        else
        {
            barHeight = parent.kBarHeight
        }
        
        parent.layoutTopTemporal = NSLayoutConstraint(
            item:next.view,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:parent.view,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:barHeight)
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
            constant:0)
        parent.layoutRightTemporal = NSLayoutConstraint(
            item:next.view,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:parent.view,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:0)
        
        parent.view.addConstraint(parent.layoutLeftTemporal!)
        parent.view.addConstraint(parent.layoutRightTemporal!)
        parent.view.addConstraint(parent.layoutTopTemporal!)
        parent.view.addConstraint(parent.layoutBottomTemporal!)
    }
    
    override func animationBefore()
    {
        next.view.alpha = 0
        parent.view.layoutIfNeeded()
    }
    
    override func animationAfter()
    {
        current?.view.alpha = 0
        next.view.alpha = 1
    }
}
