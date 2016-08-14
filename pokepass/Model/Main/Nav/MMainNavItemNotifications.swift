import Foundation

class MMainNavItemNotifications:MMainNavItem
{
    private let kImage:String = "navigationNotifications"
    
    init(index:Int)
    {
        super.init(image:kImage, index:index)
    }
}