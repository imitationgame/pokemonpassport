import Foundation

class MMainNavItemLiked:MMainNavItem
{
    private let kImage:String = "navigationLiked"
    
    init(index:Int)
    {
        super.init(image:kImage, index:index)
    }
}