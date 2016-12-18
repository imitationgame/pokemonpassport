import Foundation

class MSettingsMenuItemMetricsOptionInternational:MSettingsMenuItemMetricsOption
{
    private let kMeasure:MSettings.Measures = MSettings.Measures.metric
    
    override init()
    {
        let name:String = NSLocalizedString("MSettingsMenuItemMetricsOptionInternational_name", comment:"")
        
        super.init(name:name, measure:kMeasure)
    }
    
    override init(name:String, measure:MSettings.Measures)
    {
        fatalError()
    }
}
