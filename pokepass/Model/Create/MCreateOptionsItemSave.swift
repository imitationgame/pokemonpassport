import UIKit

class MCreateOptionsItemSave:MCreateOptionsItem
{
    private let kImage:String = "optionsSave"
    
    init()
    {
        let title:String = NSLocalizedString("MCreateOptionsItemSave_title", comment:"")
        super.init(image:kImage, title:title)
    }
    
    override func selected(controller:CCreate)
    {
        if controller.model.locations.isEmpty
        {
            VMainAlert.Message(
                message:NSLocalizedString("MCreateOptionsItemSave_empty", comment:""))
        }
        else if controller.loadedProject != nil
        {
            controller.update()
        }
        else
        {
            let alert:UIAlertController = UIAlertController(
                title:
                NSLocalizedString("MCreateOptionsItemSave_alertTitle", comment:""),
                message:
                NSLocalizedString("MCreateOptionsItemSave_alertMessage", comment:""),
                preferredStyle:UIAlertControllerStyle.alert)
            
            let actionAccept:UIAlertAction = UIAlertAction(
                title:
                NSLocalizedString("MCreateOptionsItemSave_accept", comment:""),
                style:
                UIAlertActionStyle.default)
            { [weak controller] (action) in
                
                var projectName:String = alert.textFields!.last!.text!
                
                if projectName.isEmpty
                {
                    projectName = NSLocalizedString("MCreateOptionsItemSave_noName", comment:"")
                }
                
                controller?.save(name:projectName)
            }
            
            let actionCancel:UIAlertAction = UIAlertAction(
                title:
                NSLocalizedString("MCreateOptionsItemSave_cancel", comment:""),
                style:
                UIAlertActionStyle.cancel, handler:nil)
            
            alert.addAction(actionAccept)
            alert.addAction(actionCancel)
            alert.addTextField
                { (field) in
                    
                    field.font = UIFont.regular(size:18)
                    field.keyboardAppearance = UIKeyboardAppearance.light
                    field.autocorrectionType = UITextAutocorrectionType.no
                    field.spellCheckingType = UITextSpellCheckingType.no
                    field.autocapitalizationType = UITextAutocapitalizationType.words
                    field.placeholder = NSLocalizedString("MCreateOptionsItemSave_noName", comment:"")
            }
            
            controller.present(alert, animated:true, completion:nil)
        }
    }
}
