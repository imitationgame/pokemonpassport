import Foundation

class MSettingsMenu
{
    let items:[MSettingsMenuItem]
    
    init()
    {
        let itemMetrics:MSettingsMenuItemMetrics = MSettingsMenuItem.Metrics()
        
        items = [
            itemMetrics
        ]
    }
}