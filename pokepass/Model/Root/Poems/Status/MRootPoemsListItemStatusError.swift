import Foundation

class MRootPoemsListItemStatusError:MRootPoemsListItemStatus
{
    let error:String
    
    init(item:MRootPoemsListItem, error:String)
    {
        self.error = error
        super.init(item:item)
    }
    
    override func pull(completion:((error:String?) -> ()))
    {
        item?.loadData(completion)
    }
}