import UIKit

class MMainNavItemSettings:MMainNavItem
{
    fileprivate let kImage:String = "navigationSettings"
    
    init(index:Int)
    {
        super.init(image:kImage, index:index)
    }
    
    override func controller() -> UIViewController
    {
        let settings:CSettings = CSettings()
        
        return settings
    }
}
