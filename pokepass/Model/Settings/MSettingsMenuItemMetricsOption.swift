import Foundation

class MSettingsMenuItemMetricsOption
{
    let name:String
    let measure:DPokePassSettings.DPokePassSettingsMeasure
 
    class func International() -> MSettingsMenuItemMetricsOptionInternational
    {
        let item:MSettingsMenuItemMetricsOptionInternational = MSettingsMenuItemMetricsOptionInternational()
        
        return item
    }
    
    class func Us() -> MSettingsMenuItemMetricsOptionUs
    {
        let item:MSettingsMenuItemMetricsOptionUs = MSettingsMenuItemMetricsOptionUs()
        
        return item
    }
    
    init(name:String, measure:DPokePassSettings.DPokePassSettingsMeasure)
    {
        self.name = name
        self.measure = measure
    }
}