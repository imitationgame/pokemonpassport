import UIKit

class VCreateFinder:UIView, UITextFieldDelegate
{
    weak var controller:CCreate!
    weak var field:UITextField!
    
    convenience init(controller:CCreate)
    {
        self.init()
        self.controller = controller
        clipsToBounds = true
        backgroundColor = UIColor.complement()
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
        buttonSearch.titleLabel?.font = UIFont.bold(13)
        buttonSearch.setTitleColor(UIColor.main(), forState:UIControlState.Normal)
        buttonSearch.setTitleColor(UIColor.main().colorWithAlphaComponent(0.2), forState:UIControlState.Highlighted)
        buttonSearch.setTitle(NSLocalizedString("VCreateFinder_searchButton", comment:""), forState:UIControlState.Normal)
        buttonSearch.addTarget(self, action:#selector(self.actionSearch(sender:)), forControlEvents:UIControlEvents.TouchUpInside)
        
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
        field.clearButtonMode = UITextFieldViewMode.Never
        field.placeholder = NSLocalizedString("VCreateFinder_fieldPlaceholder", comment:"")
        field.delegate = self
        field.clearsOnBeginEditing = true
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
            "H:[buttonSearch(70)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-30-[field(200)]",
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
    
    func actionSearch(sender button:UIButton)
    {
        field.resignFirstResponder()
        performSearch()
    }
    
    //MARK: private
    
    private func performSearch()
    {
        let text:String = field.text!
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0))
        { [weak self] in
            
            self?.controller.viewCreate.map.searchLocation(text)
        }
    }
    
    //MARK: field delegate
    
    func textFieldShouldReturn(textField:UITextField) -> Bool
    {
        textField.resignFirstResponder()
        performSearch()
        
        return true
    }
}