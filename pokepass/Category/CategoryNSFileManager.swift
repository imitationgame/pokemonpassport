import Foundation

extension NSFileManager
{
    class func appDirectory() -> NSURL
    {
        let urls:[NSURL] = NSFileManager.defaultManager().URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains:NSSearchPathDomainMask.UserDomainMask)
        let appDirectory:NSURL = urls.last!
        
        return appDirectory
    }
}