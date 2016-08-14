import UIKit

class VCreate:UIView
{
    weak var controller:CCreate!
    weak var map:VCreateMap!
    private let kMapHeight:CGFloat = 200
    
    convenience init(controller:CCreate)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.whiteColor()
        
        let map:VCreateMap = VCreateMap(controller:controller)
        self.map = map
        
        addSubview(map)
        
        let views:[String:AnyObject] = [
            "map":map]
        
        let metrics:[String:AnyObject] = [
            "mapHeight":kMapHeight]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[map]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[map(mapHeight)]",
            options:[],
            metrics:metrics,
            views:views))
    }
}