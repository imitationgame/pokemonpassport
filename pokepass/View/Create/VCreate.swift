import UIKit

class VCreate:UIView
{
    weak var controller:CCreate!
    weak var map:VCreateMap!
    weak var pointer:VCreateMapPointer!
    weak var options:VCreateOptions!
    weak var loader:VMainLoader!
    private let kOptionsHeight:CGFloat = 60
    
    convenience init(controller:CCreate)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.complement()
        
        let map:VCreateMap = VCreateMap(controller:controller)
        self.map = map
        
        let pointer:VCreateMapPointer = VCreateMapPointer()
        self.pointer = pointer
        
        let options:VCreateOptions = VCreateOptions(controller:controller)
        self.options = options
        
        let loader:VMainLoader = VMainLoader()
        loader.stopAnimating()
        self.loader = loader
        
        addSubview(loader)
        addSubview(map)
        addSubview(pointer)
        addSubview(options)
        
        let views:[String:AnyObject] = [
            "map":map,
            "pointer":pointer,
            "options":options,
            "loader":loader]
        
        let metrics:[String:AnyObject] = [
            "optionsHeight":kOptionsHeight]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[loader]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[map]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[pointer]-0-|",
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
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[pointer]-0-[options]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[pointer]-0-[loader]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    func showLoading()
    {
        loader.startAnimating()
        options.hidden = true
    }
    
    func hideLoading()
    {
        loader.stopAnimating()
        options.hidden = false
    }
}