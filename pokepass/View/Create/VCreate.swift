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
        button.addTarget(
            self,
            action:#selector(self.actionButton(sender:)),
            for:UIControlEvents.touchUpInside)
        self.button = button
        
        addSubview(loader)
        addSubview(finder)
        addSubview(map)
        addSubview(pointer)
        addSubview(options)
        addSubview(button)
        
        let views:[String:UIView] = [
            "map":map,
            "pointer":pointer,
            "options":options,
            "loader":loader,
            "finder":finder,
            "button":button]
        
        let metrics:[String:CGFloat] = [
            "optionsHeight":kOptionsHeight,
            "finderHeight":kFinderHeight,
            "buttonSize":kButtonSize]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[loader]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[map]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[pointer]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[options]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[finder]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[finder(finderHeight)]-0-[map]-0-[options(optionsHeight)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[finder]-0-[pointer]-0-[options]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[pointer]-0-[loader]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[button(buttonSize)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[button(buttonSize)]",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutButtonLeft = NSLayoutConstraint(
            item:button,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        
        layoutButtonTop = NSLayoutConstraint(
            item:button,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutButtonLeft)
        addConstraint(layoutButtonTop)
    }
    
    override func layoutSubviews()
    {
        layoutButtonLeft.constant = bounds.maxX / 2.0
        layoutButtonTop.constant = bounds.maxY / 2.0
        
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
        pointer.isHidden = true
        button.isHidden = true
    }
    
    func notShowingCallout()
    {
        pointer.isHidden = false
        button.isHidden = false
    }
    
    func showLoading()
    {
        loader.startAnimating()
        options.isHidden = true
    }
    
    func hideLoading()
    {
        loader.stopAnimating()
        options.isHidden = false
    }
}
