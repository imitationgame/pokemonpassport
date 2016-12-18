import Foundation

class MSettingsMenuItemMetricsOptionInternational:MSettingsMenuItemMetricsOption
{
    private let kMeasure:MSettings.Measures = MSettings.Measures.metric
    
    init()
    {
        let name:String = NSLocalizedString("MSettingsMenuItemMetricsOptionInternational_name", comment:"")
        
        super.init(name:name, measure:kMeasure)
    }
}
