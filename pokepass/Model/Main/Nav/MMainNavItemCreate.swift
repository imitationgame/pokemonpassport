import UIKit

class MMainNavItemCreate:MMainNavItem
{
    private let kImage:String = "navigationCreate"
    
    init(index:Int)
    {
        super.init(image:kImage, index:index)
    }
    
    override func controller() -> UIViewController
    {
        let create:CCreate = CCreate()
        
        return create
    }
}