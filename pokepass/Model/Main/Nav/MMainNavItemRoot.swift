import UIKit

class MMainNavItemRoot:MMainNavItem
{
    private let kImage:String = "navigationRoot"
    
    init(index:Int)
    {
        super.init(image:kImage, index:index)
    }
    
    override func controller() -> UIViewController
    {
        let create:CRoot = CRoot()
        
        return create
    }
}