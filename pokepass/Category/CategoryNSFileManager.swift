import Foundation

extension FileManager
{
    class func appDirectory() -> URL
    {
        let urls:[URL] = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in:FileManager.SearchPathDomainMask.userDomainMask)
        let appDirectory:URL = urls.last!
        
        return appDirectory
    }
}
