import Foundation

class MSettingsMenuItemMetricsOptionInternational:MSettingsMenuItemMetricsOption
{
    private let kMeasure:DPokePassSettings.DPokePassSettingsMeasure = DPokePassSettings.DPokePassSettingsMeasure.Metric
    
    init()
    {
        let name:String = NSLocalizedString("MSettingsMenuItemMetricsOptionInternational_name", comment:"")
        
        super.init(name:name, measure:kMeasure)
    }
}