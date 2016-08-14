import UIKit

extension UIViewController
{
    var parent:CMainParent
    {
        get
        {
            return self.parentViewController as! CMainParent
        }
    }
}