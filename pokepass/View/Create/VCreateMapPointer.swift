import UIKit

class VCreateMapPointer:UIView
{
    weak var cross:UIImageView!
    weak var button:UIButton!
    weak var layoutButtonLeft:NSLayoutConstraint!
    weak var layoutButtonTop:NSLayoutConstraint!
    private let kButtonSize:CGFloat = 60
    
    init()
    {
        super.init(frame:CGRectZero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        
        let cross:UIImageView = UIImageView()
        cross.userInteractionEnabled = false
        cross.translatesAutoresizingMaskIntoConstraints = false
        cross.clipsToBounds = true
        cross.contentMode = UIViewContentMode.Center
        self.cross = cross
        
        let button:UIButton = UIButton()
        button.backgroundColor = UIColor.redColor().colorWithAlphaComponent(0.3)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(cross)
        addSubview(button)
        
        let views:[String:AnyObject] = [
            "cross":cross,
            "button":button]
        
        let metrics:[String:AnyObject] = [
            "buttonSize":kButtonSize]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[cross]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[cross]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:[button(buttonSize)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[button(buttonSize)]",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutButtonLeft = NSLayoutConstraint(
            item:button,
            attribute:NSLayoutAttribute.Left,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Left,
            multiplier:1,
            constant:0)
        
        layoutButtonTop = NSLayoutConstraint(
            item:button,
            attribute:NSLayoutAttribute.Top,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Top,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutButtonLeft)
        addConstraint(layoutButtonTop)
        
        showPointer()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func showPointer()
    {
        cross.image = UIImage(named:"mapPointer")
    }
    
    func showMoving()
    {
        cross.image = UIImage(named:"mapPointerMoving")
    }
}