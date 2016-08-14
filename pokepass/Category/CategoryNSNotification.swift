import Foundation

extension NSNotification
{
    class func observeUserSynced(receiver:AnyObject, sel:Selector)
    {
        NSNotificationCenter.defaultCenter().addObserver(receiver, selector:sel, name:userSyncedName(), object:nil)
    }
    
    class func postUserSynced()
    {
        NSNotificationCenter.defaultCenter().postNotificationName(userSyncedName(), object:nil)
    }
    
    //MARK: private
    
    private class func userSyncedName() -> String
    {
        return "userSynced"
    }
}