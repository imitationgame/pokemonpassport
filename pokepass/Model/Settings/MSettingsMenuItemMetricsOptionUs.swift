import Foundation

class MSettingsMenuItemMetricsOptionUs:MSettingsMenuItemMetricsOption
{
    private let kMeasure:DPokePassSettings.DPokePassSettingsMeasure = DPokePassSettings.DPokePassSettingsMeasure.Imperial
    
    init()
    {
        let name:String = NSLocalizedString("MSettingsMenuItemMetricsOptionUs_name", comment:"")
        
        super.init(name:name, measure:kMeasure)
    }
}