import UIKit

class MMainTransitionPop:MMainTransition
{
    private let kAnimationDuration:TimeInterval = 0.4
    
    init()
    {
        super.init(animationDuration:kAnimationDuration)
    }
    
    override func positionBefore()
    {
        parent.previous = nil
        parent.view.bringSubview(toFront: current!.view)
        
        let width:CGFloat = current!.view.bounds.maxX / -2.0
        let barHeight:CGFloat = parent.kBarHeight
        
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
