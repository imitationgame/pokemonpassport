import Foundation

class MMainNavItemHome:MMainNavItem
{
    private let kImage:String = "navigationHome"
    
    init(index:Int)
    {
        super.init(image:kImage, index:index)
    }
}