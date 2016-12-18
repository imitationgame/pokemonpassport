import UIKit

extension UIColor
{
    open class var main:UIColor
    {
        get
        {
            return UIColor(red:0.2, green:0.4, blue:0.6, alpha:1)
        }
    }
    
    open class var complement:UIColor
    {
        get
        {
            return UIColor(red:0.85, green:0.9, blue:0.95, alpha:1)
        }
    }
}
