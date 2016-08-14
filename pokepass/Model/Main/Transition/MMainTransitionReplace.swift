import UIKit

class MMainTransitionReplace:MMainTransition
{
    private let kAnimationDuration:NSTimeInterval = 0
    
    init()
    {
        super.init(animationDuration:kAnimationDuration)
    }
    
    override func positionAfter()
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
            constant:0)
        parent.layoutRightTemporal = NSLayoutConstraint(
            item:next.view,
            attribute:NSLayoutAttribute.Right,
            relatedBy:NSLayoutRelation.Equal,
            toItem:parent.view,
            attribute:NSLayoutAttribute.Right,
            multiplier:1,
            constant:0)
        
        parent.view.addConstraint(parent.layoutLeftTemporal!)
        parent.view.addConstraint(parent.layoutRightTemporal!)
        parent.view.addConstraint(parent.layoutTopTemporal!)
        parent.view.addConstraint(parent.layoutBottomTemporal!)
        parent.layoutTop = parent.layoutTopTemporal
        parent.layoutBottom = parent.layoutBottomTemporal
        parent.layoutRight = parent.layoutRightTemporal
        parent.layoutLeft = parent.layoutLeftTemporal
    }
}