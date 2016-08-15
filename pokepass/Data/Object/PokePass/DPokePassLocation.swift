import Foundation
import CoreData

@objc(DPokePassLocation)
class DPokePassLocation:NSManagedObject
{
    @NSManaged var latitude:Double
    @NSManaged var longitude:Double
    @NSManaged var locationProject:DPokePassProject?
    
    override class func entityName() -> String
    {
        return "Location"
    }
}