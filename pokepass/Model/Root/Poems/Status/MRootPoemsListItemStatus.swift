import Foundation

class MRootPoemsListItemStatus
{
    weak var item:MRootPoemsListItem?
    
    class func None(item:MRootPoemsListItem) -> MRootPoemsListItemStatusNone
    {
        let status:MRootPoemsListItemStatusNone = MRootPoemsListItemStatusNone(item:item)
        
        return status
    }
    
    class func Downloading(item:MRootPoemsListItem) -> MRootPoemsListItemStatusDownloading
    {
        let status:MRootPoemsListItemStatusDownloading = MRootPoemsListItemStatusDownloading(item:item)
        
        return status
    }
    
    class func Error(item:MRootPoemsListItem, error:String) -> MRootPoemsListItemStatusError
    {
        let status:MRootPoemsListItemStatusError = MRootPoemsListItemStatusError(item:item, error:error)
        
        return status
    }
    
    class func Ready(item:MRootPoemsListItem) -> MRootPoemsListItemStatusReady
    {
        let status:MRootPoemsListItemStatusReady = MRootPoemsListItemStatusReady(item:item)
        
        return status
    }
    
    init(item:MRootPoemsListItem)
    {
        self.item = item
    }
    
    //MARK: public
    
    func pull(completion:((error:String?) -> ()))
    {
    }
}