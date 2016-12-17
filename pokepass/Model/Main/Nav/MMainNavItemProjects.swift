import UIKit

class MMainNavItemProjects:MMainNavItem
{
    fileprivate let kImage:String = "navigationProjects"
    
    init(index:Int)
    {
        super.init(image:kImage, index:index)
    }
    
    override func controller() -> UIViewController
    {
        let projects:CProjects = CProjects()
        
        return projects
    }
}
