import Foundation
import CoreData

@objc(DInfraUser)
class DInfraUser:NSManagedObject
{
    @objc enum DInfraUserAccess:Int16
    {
        case Regular = 0
        case Read
        case Banned
        case Root
    }
    
    @NSManaged private(set) var access:DInfraUserAccess
    @NSManaged private(set) var userId:String?
    @NSManaged private(set) var name:String
    @NSManaged private(set) var onboarded:Bool
    @NSManaged var createdPoem:NSSet
    @NSManaged var likedPoem:NSSet
    private var updateHandler:UInt?
    
    override class func entityName() -> String
    {
        return "User"
    }
    
    //MARK: public
    
    func syncUser()
    {
        if userId == nil
        {
            let fUser:FDatabaseModelUser = FDatabaseModelUser(dbUser:self)
            userId = FMain.sharedInstance.database.newUser(fUser)
        }
        
        updateHandler = FMain.sharedInstance.database.listenUser(userId!)
        { [weak self] (snapshot) in
            
            let fUser:FDatabaseModelUser = FDatabaseModelUser(snapshot:snapshot.value)
            self?.access = fUser.access
            self?.name = fUser.name
            
            MConfiguration.sharedInstance.userSynced()
        }
    }
    
    func stopSyncing()
    {
        if userId != nil && updateHandler != nil
        {
            FMain.sharedInstance.database.stopListener(userId!, handler:updateHandler!)
        }
    }
    
    func updateName(name:String)
    {
        self.name = name
        let fUser:FDatabaseModelUser = FDatabaseModelUser(dbUser:self)
        let propertyName:[String:AnyObject] = fUser.propertyName()
        FMain.sharedInstance.database.updateUser(userId!, property:propertyName)
    }
    
    func onboardingDone()
    {
        onboarded = true
        DManager.sharedInstance.managerInfra.saver.save(false)
    }
}