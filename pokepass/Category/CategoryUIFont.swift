import UIKit

extension UIFont
{
    class func regular(_ size:CGFloat) -> UIFont
    {
        return UIFont(name:"AvenirNext-Regular", size:size)!
    }
    
    class func bold(_ size:CGFloat) -> UIFont
    {
        return UIFont(name:"AvenirNext-DemiBold", size:size)!
    }
    
    class func numeric(_ size:CGFloat) -> UIFont
    {
        return UIFont(name:"AvenirNextCondensed-Bold", size:size)!
    }
}
