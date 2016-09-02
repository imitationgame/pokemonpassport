import UIKit

class VCreate:UIView
{
    weak var controller:CCreate!
    weak var map:VCreateMap!
    weak var pointer:VCreateMapPointer!
    weak var options:VCreateOptions!
    weak var loader:VMainLoader!
    weak var finder:VCreateFinder!
    weak var button:UIButton!
    weak var layoutButtonLeft:NSLayoutConstraint!
    weak var layoutButtonTop:NSLayoutConstraint!
    private let kOptionsHeight:CGFloat = 60
    private let kFinderHeight:CGFloat = 40
    private let kButtonSize:CGFloat = 50
    
    convenience init(controller:CCreate)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.complement()
        self.controller = controller
        
        let map:VCreateMap = VCreateMap(controller:controller)
        self.map = map
        
        let pointer:VCreateMapPointer = VCreateMapPointer()
        self.pointer = pointer
        
        let options:VCreateOptions = VCreateOptions(controller:controller)
        self.options = options
        
        let finder:VCreateFinder = VCreateFinder(controller:controller)
        self.finder = finder
        
        let loader:VMainLoader = VMainLoader()
        loader.stopAnimating()
        self.loader = loader
        
        let button:UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action:#selector(self.actionButton(sender:)), forControlEvents:UIControlEvents.TouchUpInside)
        self.button = button
        
        addSubview(loader)
        addSubview(finder)
        addSubview(map)
        addSubview(pointer)
        addSubview(options)
        addSubview(button)
        
        let views:[String:AnyObject] = [
            "map":map,
            "pointer":pointer,
            "options":options,
            "loader":loader,
            "finder":finder,
            "button":button]
        
        let metrics:[String:AnyObject] = [
            "optionsHeight":kOptionsHeight,
            "finderHeight":kFinderHeight,
            "buttonSize":kButtonSize]
        
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
            "H:|-0-[finder]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[finder(finderHeight)]-0-[map]-0-[options(optionsHeight)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[finder]-0-[pointer]-0-[options]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[pointer]-0-[loader]-0-|",
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
    }
    
    override func layoutSubviews()
    {
        let center:CGPoint = pointer.center
        layoutButtonLeft.constant = center.x
        layoutButtonTop.constant = center.y
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionButton(sender button:UIButton)
    {
        controller.addLocation()
    }
    
    //MARK: public
    
    func showingCallout()
    {
        pointer.hidden = true
        button.hidden = true
    }
    
    func notShowingCallout()
    {
        pointer.hidden = false
        button.hidden = false
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