import UIKit

class MSettingsMenuItem
{
    weak var cell:VSettingsCell!
    weak var controller:CSettings!
    let reusableIdentifier:String
    let cellHeight:CGFloat
    
    class func Metrics() -> MSettingsMenuItemMetrics
    {
        let item:MSettingsMenuItemMetrics = MSettingsMenuItemMetrics()
        
        return item
    }
    
    init(reusableIdentifier:String, cellHeight:CGFloat)
    {
        self.reusableIdentifier = reusableIdentifier
        self.cellHeight = cellHeight
    }
    
    //MARK: public
    
    func config(cell:VSettingsCell, controller:CSettings)
    {
        self.cell = cell
        self.controller = controller
    }
    
    func selected()
    {
    }
}