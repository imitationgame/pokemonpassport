import UIKit

class CMainController:UIViewController
{
    var parentController:CMainParent
    {
        get
        {
            return self.parent as! CMainParent
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        edgesForExtendedLayout = UIRectEdge()
        extendedLayoutIncludesOpaqueBars = false
        automaticallyAdjustsScrollViewInsets = false
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle
    {
        return UIStatusBarStyle.default
    }
    
    override var prefersStatusBarHidden : Bool
    {
        return false
    }
}
