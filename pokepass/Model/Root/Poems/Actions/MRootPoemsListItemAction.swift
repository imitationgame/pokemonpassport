import Foundation

class MRootPoemsListItemAction
{
    let image:String
    
    class func Accept() -> MRootPoemsListItemActionAccept
    {
        let action:MRootPoemsListItemActionAccept = MRootPoemsListItemActionAccept()
        
        return action
    }
    
    class func Reject() -> MRootPoemsListItemActionReject
    {
        let action:MRootPoemsListItemActionReject = MRootPoemsListItemActionReject()
        
        return action
    }
    
    class func Revision() -> MRootPoemsListItemActionRevision
    {
        let action:MRootPoemsListItemActionRevision = MRootPoemsListItemActionRevision()
        
        return action
    }
    
    init(image:String)
    {
        self.image = image
    }
    
    //MARK: public
    
    func selected(model:MRootPoemsListItem, controller:CRootList, onAction:((done:Bool) -> ())?)
    {
    }
}