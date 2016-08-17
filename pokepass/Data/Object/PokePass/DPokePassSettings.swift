import Foundation
import CoreData

@objc(DPokePassSettings)
class DPokePassSettings:NSManagedObject
{
    @objc enum DPokePassSettingsMeasure:Int16
    {
        case Metric = 0
        case Imperial
    }
    
    @NSManaged var measures:DPokePassSettingsMeasure
}