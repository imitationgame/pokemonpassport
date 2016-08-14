import UIKit

class MRootPoemsListItemActionAccept:MRootPoemsListItemAction
{
    private let kImage:String = "rootAccept"
    
    init()
    {
        super.init(image:kImage)
    }
    
    override func selected(model:MRootPoemsListItem, controller:CRootList, onAction:((done:Bool) -> ())?)
    {
        let alert:UIAlertController = UIAlertController(
            title:
            NSLocalizedString("MRootPoemsListItemActionAccept_title", comment:""),
            message:
            model.title,
            preferredStyle:UIAlertControllerStyle.ActionSheet)
        
        let actionAccept:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("MRootPoemsListItemActionAccept_accept", comment:""),
            style:
            UIAlertActionStyle.Default)
        { [weak model] (action) in
            
            model?.accept()
            onAction?(done:true)
        }
        
        let actionCancel:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("MRootPoemsListItemActionAccept_cancel", comment:""),
            style:
            UIAlertActionStyle.Cancel)
        { (action) in
            
            onAction?(done:false)
        }
        
        alert.addAction(actionAccept)
        alert.addAction(actionCancel)
        controller.presentViewController(alert, animated:true, completion:nil)
    }
}