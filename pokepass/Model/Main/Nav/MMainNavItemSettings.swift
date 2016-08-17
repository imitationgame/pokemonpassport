import UIKit

class MMainNavItemSettings:MMainNavItem
{
    private let kImage:String = "navigationSettings"
    
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