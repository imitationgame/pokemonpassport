import Foundation

class MSettingsMenuItemMetricsOptionInternational:MSettingsMenuItemMetricsOption
{
    fileprivate let kMeasure:DPokePassSettings.DPokePassSettingsMeasure = DPokePassSettings.DPokePassSettingsMeasure.metric
    
    init()
    {
        let name:String = NSLocalizedString("MSettingsMenuItemMetricsOptionInternational_name", comment:"")
        
        super.init(name:name, measure:kMeasure)
    }
}
