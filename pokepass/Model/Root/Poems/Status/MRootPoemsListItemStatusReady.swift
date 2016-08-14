import Foundation

class MRootPoemsListItemStatusReady:MRootPoemsListItemStatus
{
    override func pull(completion:((error:String?) -> ()))
    {
        completion(error:nil)
    }
}