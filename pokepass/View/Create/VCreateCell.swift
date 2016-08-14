import UIKit

class VCreateCell:UICollectionViewCell
{
    weak var base:UIView!
    weak var layoutBaseTop:NSLayoutConstraint!
    weak var layoutBaseBottom:NSLayoutConstraint!
    weak var layoutBaseRight:NSLayoutConstraint!
    weak var layoutBaseLeft:NSLayoutConstraint!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        backgroundColor = UIColor.clearColor()
        clipsToBounds = true
        
        let base:UIView = UIView()
        base.clipsToBounds = true
        base.backgroundColor = UIColor.whiteColor()
        base.translatesAutoresizingMaskIntoConstraints = false
        base.layer.borderWidth = 1
        base.layer.borderColor = UIColor(white:0, alpha:0.1).CGColor
        self.base = base
        
        addSubview(base)
        
        layoutBaseTop = NSLayoutConstraint(
            item:base,
            attribute:NSLayoutAttribute.Top,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Top,
            multiplier:1,
            constant:0)
        layoutBaseBottom = NSLayoutConstraint(
            item:base,
            attribute:NSLayoutAttribute.Bottom,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Bottom,
            multiplier:1,
            constant:0)
        layoutBaseRight = NSLayoutConstraint(
            item:base,
            attribute:NSLayoutAttribute.Right,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Right,
            multiplier:1,
            constant:0)
        layoutBaseLeft = NSLayoutConstraint(
            item:base,
            attribute:NSLayoutAttribute.Left,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Left,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutBaseTop)
        addConstraint(layoutBaseBottom)
        addConstraint(layoutBaseRight)
        addConstraint(layoutBaseLeft)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}