import UIKit

class MMainNavItem
{
    let image:String
    let index:Int
    private(set) var state:MMainNavItemState
    weak var cell:VMainBarCell?
    
    class func Projects(index:Int) -> MMainNavItem
    {
        let item:MMainNavItem = MMainNavItemProjects(index:index)
        
        return item
    }
    
    class func Create(index:Int) -> MMainNavItem
    {
        let item:MMainNavItem = MMainNavItemCreate(index:index)
        
        return item
    }
    
    class func Settings(index:Int) -> MMainNavItem
    {
        let item:MMainNavItem = MMainNavItemSettings(index:index)
        
        return item
    }
    
    init(image:String, index:Int)
    {
        self.image = image
        self.index = index
        state = MMainNavItemState.None()
    }
    
    //MARK: public
 
    func restate(state:MMainNavItemState)
    {
        self.state = state
        cell?.image.tintColor = state.color
    }
    
    func config(cell:VMainBarCell)
    {
        self.cell = cell
        cell.image.image = UIImage(named:image)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        cell.image.tintColor = state.color
    }
    
    func selected()
    {
    }
    
    func controller() -> UIViewController
    {
        let controller:UIViewController = CProjects()
        
        return controller
    }
}