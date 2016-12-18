import Foundation

class MSettingsMenuItemMetricsOption
{
    let name:String
    let measure:MSettings.Measures

    init(name:String, measure:MSettings.Measures)
    {
        self.name = name
        self.measure = measure
    }
}
