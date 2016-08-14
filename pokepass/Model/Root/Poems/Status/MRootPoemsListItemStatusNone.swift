import Foundation

class MRootPoemsListItemStatusNone:MRootPoemsListItemStatus
{
    override func pull(completion:((error:String?) -> ()))
    {
        item?.loadData(completion)
    }
}