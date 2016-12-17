import Foundation

class MSettingsMenuItemMetricsOptionUs:MSettingsMenuItemMetricsOption
{
    fileprivate let kMeasure:DPokePassSettings.DPokePassSettingsMeasure = DPokePassSettings.DPokePassSettingsMeasure.imperial
    
    init()
    {
        let name:String = NSLocalizedString("MSettingsMenuItemMetricsOptionUs_name", comment:"")
        
        super.init(name:name, measure:kMeasure)
    }
}
