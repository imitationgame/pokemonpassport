import Foundation

class MMainNavItemProfile:MMainNavItem
{
    private let kImage:String = "navigationProfile"
    
    init(index:Int)
    {
        super.init(image:kImage, index:index)
    }
}