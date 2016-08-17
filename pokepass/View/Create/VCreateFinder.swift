import UIKit

class VCreateFinder:UIView, UITextFieldDelegate
{
    weak var controller:CCreate!
    weak var field:UITextField!
    
    convenience init(controller:CCreate)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor(white:0.95, alpha:1)
        translatesAutoresizingMaskIntoConstraints = false
        
        let image:UIImageView = UIImageView()
        image.image = UIImage(named:"search")
        image.userInteractionEnabled = false
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = UIViewContentMode.Center
        
        let border:UIView = UIView()
        border.backgroundColor = UIColor.main()
        border.userInteractionEnabled = false
        border.translatesAutoresizingMaskIntoConstraints = false
        border.clipsToBounds = true
        
        let button:UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action:#selector(self.actionButton(sender:)), forControlEvents:UIControlEvents.TouchUpInside)
        
        let buttonSearch:UIButton = UIButton()
        buttonSearch.translatesAutoresizingMaskIntoConstraints = false
        buttonSearch.backgroundColor = UIColor.main()
        buttonSearch.setTitleColor(UIColor.whiteColor(), forState:UIControlState.Normal)
        buttonSearch.setTitleColor(UIColor(white:1, alpha:0.2), forState:UIControlState.Highlighted)
        buttonSearch.setTitle(NSLocalizedString("VCreateFinder_searchButton", comment:""), forState:UIControlState.Normal)
        
        let field:UITextField = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.clipsToBounds = true
        field.backgroundColor = UIColor.clearColor()
        field.borderStyle = UITextBorderStyle.None
        field.font = UIFont.regular(16)
        field.textColor = UIColor.blackColor()
        field.tintColor = UIColor.blackColor()
        field.returnKeyType = UIReturnKeyType.Search
        field.keyboardAppearance = UIKeyboardAppearance.Light
        field.autocorrectionType = UITextAutocorrectionType.No
        field.spellCheckingType = UITextSpellCheckingType.No
        field.autocapitalizationType = UITextAutocapitalizationType.Words
        field.clearButtonMode = UITextFieldViewMode.WhileEditing
        field.placeholder = NSLocalizedString("VCreateFinder_fieldPlaceholder", comment:"")
        field.delegate = self
        self.field = field
        
        addSubview(border)
        addSubview(image)
        addSubview(button)
        addSubview(field)
        addSubview(buttonSearch)
        
        let views:[String:AnyObject] = [
            "border":border,
            "image":image,
            "button":button,
            "buttonSearch":buttonSearch,
            "field":field]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[border]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[button]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-30-[field]-0-[buttonSearch(60)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-5-[image(20)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[border(1)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[image]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[button]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[field]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[buttonSearch]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    //MARK: actions
    
    func actionButton(sender button:UIButton)
    {
        field.becomeFirstResponder()
    }
    
    //MARK: field delegate
    
    func textField(textField:UITextField, shouldChangeCharactersInRange range:NSRange, replacementString string:String) -> Bool
    {
        let nsString:NSString = textField.text! as NSString
        let query:String = textField.text!.stringByReplacingCharactersInRange(range, withString:string)
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0))
        { [weak self] in
            
            let newString:String = nsString.stringByReplacingCharactersInRange(range, withString:string)
            self?.searchQuery(newString)
        }
        
        
        return true
    }
    
    func textFieldShouldReturn(textField:UITextField) -> Bool
    {
        textField.resignFirstResponder()
        
        return true
    }
}