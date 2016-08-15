import UIKit

class MCreateOptionsItemSave:MCreateOptionsItem, UITextFieldDelegate
{
    private let kImage:String = "optionsSave"
    
    init()
    {
        let title:String = NSLocalizedString("MCreateOptionsItemSave_title", comment:"")
        super.init(image:kImage, title:title)
    }
    
    override func selected(controller:CCreate)
    {
        let alert:UIAlertController = UIAlertController(
            title:
            NSLocalizedString("MCreateOptionsItemSave_alerttitle", comment:""),
            message:
            NSLocalizedString("MCreateOptionsItemSave_alertMessage", comment:""),
            preferredStyle:UIAlertControllerStyle.Alert)
        
        let actionAccept:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("MCreateOptionsItemSave_accept", comment:""),
            style:
            UIAlertActionStyle.Default)
        { [weak controller] (action) in
            
            var projectName:String = alert.textFields!.last!.text!
            
            if projectName.isEmpty
            {
                projectName = NSLocalizedString("MCreateOptionsItemSave_noName", comment:"")
            }
            
            controller?.save(projectName)
        }
        
        let actionCancel:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("MCreateOptionsItemSave_cancel", comment:""),
            style:
            UIAlertActionStyle.Cancel, handler:nil)
        
        alert.addAction(actionAccept)
        alert.addAction(actionCancel)
        alert.addTextFieldWithConfigurationHandler
        { (field) in
            
            field.delegate = self
        }
        controller.presentViewController(alert, animated:true, completion:nil)
    }
    
    //MARK: field delegate
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}