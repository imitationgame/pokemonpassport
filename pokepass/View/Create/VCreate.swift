import UIKit

class VCreate:UIView
{
    weak var controller:CCreate!
    weak var map:VCreateMap!
    weak var options:VCreateOptions!
    private let kOptionsHeight:CGFloat = 60
    
    convenience init(controller:CCreate)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.whiteColor()
        
        let map:VCreateMap = VCreateMap(controller:controller)
        self.map = map
        
        let options:VCreateOptions = VCreateOptions(controller:controller)
        self.options = options
        
        addSubview(map)
        addSubview(options)
        
        let views:[String:AnyObject] = [
            "map":map,
            "options":options]
        
        let metrics:[String:AnyObject] = [
            "optionsHeight":kOptionsHeight]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[map]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[options]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[map]-0-[options(optionsHeight)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
}