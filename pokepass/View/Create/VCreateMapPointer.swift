import UIKit

class VCreateMapPointer:UIView
{
    weak var cross:UIImageView!
    
    init()
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        
        let cross:UIImageView = UIImageView()
        cross.isUserInteractionEnabled = false
        cross.translatesAutoresizingMaskIntoConstraints = false
        cross.clipsToBounds = true
        cross.contentMode = UIViewContentMode.center
        self.cross = cross
        
        addSubview(cross)
        
        let views:[String:AnyObject] = [
            "cross":cross]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[cross]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[cross]-0-|",
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
