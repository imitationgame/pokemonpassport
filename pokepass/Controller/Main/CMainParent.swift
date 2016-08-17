import UIKit

class CMainParent:UIViewController
{
    let kBarHeight:CGFloat = 64
    weak var bar:VMainBar?
    weak var current:UIViewController?
    weak var layoutLeft:NSLayoutConstraint?
    weak var layoutRight:NSLayoutConstraint?
    weak var layoutTop:NSLayoutConstraint?
    weak var layoutBottom:NSLayoutConstraint?
    weak var layoutLeftTemporal:NSLayoutConstraint?
    weak var layoutRightTemporal:NSLayoutConstraint?
    weak var layoutTopTemporal:NSLayoutConstraint?
    weak var layoutBottomTemporal:NSLayoutConstraint?
    weak var shadow:VMainShadow?
    var previous:UIViewController?
    private var statusBarStyle:UIStatusBarStyle = UIStatusBarStyle.LightContent
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let projects:CProjects = CProjects()
        loadBar()
        pushController(projects, transition:MMainTransition.Replace())
        
        MSettings.sharedInstance.load()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle
    {
        return statusBarStyle
    }
    
    override func prefersStatusBarHidden() -> Bool
    {
        return false
    }
    
    //MARK: public
    
    func statusBarLight()
    {
        statusBarStyle = UIStatusBarStyle.LightContent
        setNeedsStatusBarAppearanceUpdate()
    }
    
    func statusBarDefault()
    {
        statusBarStyle = UIStatusBarStyle.Default
        setNeedsStatusBarAppearanceUpdate()
    }
    
    func loadBar()
    {
        let bar:VMainBar = VMainBar(controllerParent:self)
        self.bar = bar
        
        view.addSubview(bar)
        
        let views:[String:AnyObject] = [
            "bar":bar]
        
        let metrics:[String:AnyObject] = [
            "barHeight":kBarHeight]
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[bar]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[bar(barHeight)]",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    func pushController(controller:UIViewController, transition:MMainTransition)
    {
        transition.prepare(self, current:current, next:controller)
        addChildViewController(controller)
        view.addSubview(controller.view)
        transition.positionBefore()
        
        if current == nil
        {
            transition.positionAfter()
            
            view.addSubview(controller.view)
            controller.didMoveToParentViewController(self)
            current = controller
        }
        else
        {
            current!.willMoveToParentViewController(nil)
            transition.animationBefore()
            transition.positionAfter()
            
            UIView.animateWithDuration(transition.animationDuration, animations:
            {
                transition.animationAfter()
                
            }, completion:
            { (done) in
                
                transition.completed()
                
                self.current!.view.removeFromSuperview()
                self.current!.removeFromParentViewController()
                controller.didMoveToParentViewController(self)
                self.current = controller
                self.layoutRight = self.layoutRightTemporal
                self.layoutLeft = self.layoutLeftTemporal
                self.layoutTop = self.layoutTopTemporal
                self.layoutBottom = self.layoutBottomTemporal
            })
        }
    }
    
    func backController()
    {
        if previous != nil
        {
            let controller:UIViewController = previous!
            let transition:MMainTransition = MMainTransition.Pop()
            pushController(controller, transition:transition)
        }
    }
}