import UIKit

class MMainTransitionPop:MMainTransition
{
    private let kAnimationDuration:NSTimeInterval = 0.4
    
    init()
    {
        super.init(animationDuration:kAnimationDuration)
    }
    
    override func positionBefore()
    {
        parent.previous = nil
        parent.view.bringSubviewToFront(current!.view)
        
        let width:CGFloat = current!.view.bounds.maxX / -2.0
        let barHeight:CGFloat = parent.kBarHeight
        
        parent.layoutTopTemporal = NSLayoutConstraint(
            item:next.view,
            attribute:NSLayoutAttribute.Top,
            relatedBy:NSLayoutRelation.Equal,
            toItem:parent.view,
            attribute:NSLayoutAttribute.Top,
            multiplier:1,
            constant:barHeight)
        parent.layoutBottomTemporal = NSLayoutConstraint(
            item:next.view,
            attribute:NSLayoutAttribute.Bottom,
            relatedBy:NSLayoutRelation.Equal,
            toItem:parent.view,
            attribute:NSLayoutAttribute.Bottom,
            multiplier:1,
            constant:0)
        parent.layoutLeftTemporal = NSLayoutConstraint(
            item:next.view,
            attribute:NSLayoutAttribute.Left,
            relatedBy:NSLayoutRelation.Equal,
            toItem:parent.view,
            attribute:NSLayoutAttribute.Left,
            multiplier:1,
            constant:width)
        parent.layoutRightTemporal = NSLayoutConstraint(
            item:next.view,
            attribute:NSLayoutAttribute.Right,
            relatedBy:NSLayoutRelation.Equal,
            toItem:parent.view,
            attribute:NSLayoutAttribute.Right,
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
        let width:CGFloat = current!.view.bounds.maxX
        parent.layoutLeft!.constant = width
        parent.layoutRight!.constant = width
        parent.layoutLeftTemporal!.constant = 0
        parent.layoutRightTemporal!.constant = 0
        parent.bar?.poped()
    }
    
    override func animationAfter()
    {
        parent.view.layoutIfNeeded()
        parent.shadow?.alpha = 0
    }
    
    override func completed()
    {
        parent.shadow?.removeFromSuperview()
        parent.bar?.back.label.text = ""
    }
}