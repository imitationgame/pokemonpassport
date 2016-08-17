import UIKit

class MSettingsMenuItem
{
    weak var cell:VSettingsCell!
    weak var controller:CSettings!
    
    class func Metrics() -> MSettingsMenuItemMetrics
    {
        let item:MSettingsMenuItemMetrics = MSettingsMenuItemMetrics()
        
        return item
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