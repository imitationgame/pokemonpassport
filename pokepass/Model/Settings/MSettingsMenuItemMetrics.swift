import UIKit

class MSettingsMenuItemMetrics:MSettingsMenuItem
{
    private let kCellHeight:CGFloat = 120
    
    init()
    {
        let reusableIdentifier:String = VSettingsCellMetrics.reusableIdentifier()
        
        super.init(reusableIdentifier:reusableIdentifier, cellHeight:kCellHeight)
    }
}