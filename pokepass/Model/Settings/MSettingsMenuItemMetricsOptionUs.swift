import Foundation

class MSettingsMenuItemMetricsOptionUs:MSettingsMenuItemMetricsOption
{
    private let kMeasure:MSettings.Measures = MSettings.Measures.imperial
    
    init()
    {
        let name:String = NSLocalizedString("MSettingsMenuItemMetricsOptionUs_name", comment:"")
        
        super.init(name:name, measure:kMeasure)
    }
}
