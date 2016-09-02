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
 
    override class func entityName() -> String
    {
        return "Settings"
    }
    
    @NSManaged var measures:DPokePassSettingsMeasure
}