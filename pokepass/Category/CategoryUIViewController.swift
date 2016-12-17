import UIKit

extension UIViewController
{
    var parent:CMainParent
    {
        get
        {
            return self.parent as! CMainParent
        }
    }
}
