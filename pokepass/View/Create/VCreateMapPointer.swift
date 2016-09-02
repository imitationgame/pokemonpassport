import UIKit

class VCreateMapPointer:UIView
{
    weak var cross:UIImageView!
    
    init()
    {
        super.init(frame:CGRectZero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        userInteractionEnabled = false
        
        let cross:UIImageView = UIImageView()
        cross.userInteractionEnabled = false
        cross.translatesAutoresizingMaskIntoConstraints = false
        cross.clipsToBounds = true
        cross.contentMode = UIViewContentMode.Center
        self.cross = cross
        
        addSubview(cross)
        
        let views:[String:AnyObject] = [
            "cross":cross]
        
        let metrics:[String:AnyObject] = [:]
        
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
    
    func showShutter()
    {
        cross.image = UIImage(named:"mapPointerShutter")
    }
}