import UIKit

class MMainTransitionScrollRight:MMainTransition
{
    private let kAnimationDuration:TimeInterval = 0.3
    
    init()
    {
        super.init(animationDuration:kAnimationDuration)
    }
    
    override func positionBefore()
    {
        let width:CGFloat
        let barHeight:CGFloat
        
        if current == nil
        {
            width = 0
        }
        else
        {
            width = current!.view.bounds.maxX
        }
        
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
    }
    
    override func animationBefore()
    {
        parent.view.layoutIfNeeded()
    }
    
    override func positionAfter()
    {
        if current != nil
        {
            let width:CGFloat = current!.view.bounds.maxX
            parent.layoutLeft!.constant = -width
            parent.layoutRight!.constant = -width
        }
        
        parent.layoutLeftTemporal!.constant = 0
        parent.layoutRightTemporal!.constant = 0
    }
    
    override func animationAfter()
    {
        parent.view.layoutIfNeeded()
    }
}
