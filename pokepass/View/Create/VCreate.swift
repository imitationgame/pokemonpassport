import UIKit

class VCreate:UIView
{
    weak var controller:CCreate!
    weak var map:VCreateMap!
    weak var pointer:VCreateMapPointer!
    weak var options:VCreateOptions!
    weak var finder:VCreateFinder!
    weak var history:VCreateHistory!
    weak var button:UIButton!
    weak var layoutButtonLeft:NSLayoutConstraint!
    weak var layoutButtonTop:NSLayoutConstraint!
    private let kOptionsHeight:CGFloat = 64
    private let kFinderHeight:CGFloat = 44
    private let kHistoryHeight:CGFloat = 60
    private let kButtonSize:CGFloat = 50
    
    convenience init(controller:CCreate)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.complement
        self.controller = controller
        
        let map:VCreateMap = VCreateMap(controller:controller)
        self.map = map
        
        let pointer:VCreateMapPointer = VCreateMapPointer()
        self.pointer = pointer
        
        let options:VCreateOptions = VCreateOptions(controller:controller)
        self.options = options
        
        let finder:VCreateFinder = VCreateFinder(controller:controller)
        self.finder = finder
        
        let history:VCreateHistory = VCreateHistory(controller:controller)
        self.history = history
        
        let button:UIButton = UIButton()
        button.backgroundColor = UIColor.red.withAlphaComponent(0.3)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(
            self,
            action:#selector(self.actionButton(sender:)),
            for:UIControlEvents.touchUpInside)
        button.addTarget(
            self,
            action:#selector(self.actionHover(sender:)),
            for:UIControlEvents.touchDown)
        button.addTarget(
            self,
            action:#selector(self.actionUnHover(sender:)),
            for:UIControlEvents.touchUpOutside)
        button.addTarget(
            self,
            action:#selector(self.actionUnHover(sender:)),
            for:UIControlEvents.touchDragOutside)
        self.button = button
        
        addSubview(finder)
        addSubview(map)
        addSubview(history)
        addSubview(pointer)
        addSubview(options)
        addSubview(button)
        
        let views:[String:UIView] = [
            "map":map,
            "pointer":pointer,
            "options":options,
            "finder":finder,
            "button":button,
            "history":history]
        
        let metrics:[String:CGFloat] = [
            "optionsHeight":kOptionsHeight,
            "finderHeight":kFinderHeight,
            "buttonSize":kButtonSize,
            "historyHeight":kHistoryHeight]
        
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
            withVisualFormat:"H:|-0-[history]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[options(optionsHeight)]-0-[finder(finderHeight)]-0-[map]-0-[history(historyHeight)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[finder]-0-[pointer]-0-|",
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
        layoutButtonTop.constant = (bounds.maxY + kOptionsHeight + kFinderHeight - kHistoryHeight) / 2.0
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionHover(sender button:UIButton)
    {
        if controller.movingAnnotation == nil
        {
            controller.viewCreate.pointer.showSelected()
        }
        else
        {
            controller.viewCreate.pointer.showMovingSelected()
        }
    }
    
    func actionUnHover(sender button:UIButton)
    {
        if controller.movingAnnotation == nil
        {
            controller.viewCreate.pointer.showPointer()
        }
        else
        {
            controller.viewCreate.pointer.showMoving()
        }
    }
    
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
        options.isHidden = true
    }
    
    func hideLoading()
    {
        options.isHidden = false
    }
}
