import Foundation
import CoreData

@objc(DPokePassSettings)
class DPokePassSettings:NSManagedObject
{
    @objc enum DPokePassSettingsMeasure:Int16
    {
        case metric = 0
        case imperial
    }
 
    override class func entityName() -> String
    {
        return "Settings"
    }
    
    @NSManaged var measures:DPokePassSettingsMeasure
}
