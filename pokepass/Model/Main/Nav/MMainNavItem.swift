import UIKit

class MMainNavItem
{
    let image:String
    let index:Int
    private(set) var state:MMainNavItemState
    weak var cell:VMainBarCell?
    
    init(image:String, index:Int)
    {
        self.image = image
        self.index = index
        state = MMainNavItemStateNone()
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
        cell.image.image = UIImage(named:image)?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
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
