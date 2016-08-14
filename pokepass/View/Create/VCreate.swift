import UIKit

class VCreate:UIView
{
    weak var controller:CCreate!
    weak var map:VCreateMap!
    weak var locations:VCreateLocations!
    weak var options:VCreateOptions!
    private let kLocationsHeight:CGFloat = 100
    private let kOptionsHeight:CGFloat = 60
    
    convenience init(controller:CCreate)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.whiteColor()
        
        let map:VCreateMap = VCreateMap(controller:controller)
        self.map = map
        
        let locations:VCreateLocations = VCreateLocations(controller:controller)
        self.locations = locations
        
        let options:VCreateOptions = VCreateOptions(controller:controller)
        self.options = options
        
        addSubview(map)
        addSubview(locations)
        addSubview(options)
        
        let views:[String:AnyObject] = [
            "map":map,
            "locations":locations,
            "options":options]
        
        let metrics:[String:AnyObject] = [
            "locationsHeight":kLocationsHeight,
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
            "H:|-0-[locations]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[map]-0-[locations(locationsHeight)]-0-[options(optionsHeight)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
}