import Foundation
import CoreData

@objc(DInfraPoem)
class DInfraPoem:NSManagedObject
{
    @objc enum DInfraPoemStatus:Int16
    {
        case Uploading = 0
        case Review
        case NeedsRevision
        case Rejected
        case Ready
    }
    
    @NSManaged private(set) var status:DInfraPoemStatus
    @NSManaged private(set) var poemId:String
    @NSManaged var userCreator:DInfraUser?
    @NSManaged var userLiked:DInfraUser?
    
    override class func entityName() -> String
    {
        return "Poem"
    }
    
    //MARK: public
    
    func justSaved(poemId:String)
    {
        self.poemId = poemId
        status = DInfraPoemStatus.Review
        userCreator = MConfiguration.sharedInstance.user
        
        DManager.sharedInstance.managerInfra.saver.save(false)
    }
}