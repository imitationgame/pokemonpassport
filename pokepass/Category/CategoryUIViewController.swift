import UIKit

extension UIViewController
{
    var parentController:CMainParent
    {
        get
        {
            return self.parent as! CMainParent
        }
    }
}
