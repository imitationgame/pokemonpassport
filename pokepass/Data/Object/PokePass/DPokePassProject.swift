import Foundation
import CoreData

@objc(DPokePassProject)
class DPokePassProject:NSManagedObject
{
    @NSManaged var name:String?
    @NSManaged var projectLocations:NSOrderedSet?
    
    override class func entityName() -> String
    {
        return "Project"
    }
}