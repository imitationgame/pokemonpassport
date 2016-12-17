import Foundation

extension Notification
{
    static func observeUserSynced(_ receiver:AnyObject, sel:Selector)
    {
        NotificationCenter.default.addObserver(receiver, selector:sel, name:NSNotification.Name(rawValue: userSyncedName()), object:nil)
    }
    
    static func postUserSynced()
    {
        NotificationCenter.default.post(name: Notification.Name(rawValue: userSyncedName()), object:nil)
    }
    
    //MARK: private
    
    fileprivate static func userSyncedName() -> String
    {
        return "userSynced"
    }
}
