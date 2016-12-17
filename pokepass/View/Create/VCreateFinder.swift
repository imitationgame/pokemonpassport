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
        image.isUserInteractionEnabled = false
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = UIViewContentMode.center
        
        let border:UIView = UIView()
        border.backgroundColor = UIColor.main()
        border.isUserInteractionEnabled = false
        border.translatesAutoresizingMaskIntoConstraints = false
        border.clipsToBounds = true
        
        let button:UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action:#selector(self.actionButton(sender:)), for:UIControlEvents.touchUpInside)
        
        let buttonSearch:UIButton = UIButton()
        buttonSearch.translatesAutoresizingMaskIntoConstraints = false
        buttonSearch.titleLabel?.font = UIFont.bold(13)
        buttonSearch.setTitleColor(UIColor.main(), for:UIControlState())
        buttonSearch.setTitleColor(UIColor.main().withAlphaComponent(0.2), for:UIControlState.highlighted)
        buttonSearch.setTitle(NSLocalizedString("VCreateFinder_searchButton", comment:""), for:UIControlState())
        buttonSearch.addTarget(self, action:#selector(self.actionSearch(sender:)), for:UIControlEvents.touchUpInside)
        
        let field:UITextField = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.clipsToBounds = true
        field.backgroundColor = UIColor.clear
        field.borderStyle = UITextBorderStyle.none
        field.font = UIFont.regular(16)
        field.textColor = UIColor.black
        field.tintColor = UIColor.black
        field.returnKeyType = UIReturnKeyType.search
        field.keyboardAppearance = UIKeyboardAppearance.light
        field.autocorrectionType = UITextAutocorrectionType.no
        field.spellCheckingType = UITextSpellCheckingType.no
        field.autocapitalizationType = UITextAutocapitalizationType.words
        field.clearButtonMode = UITextFieldViewMode.never
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
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[border]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[button]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:[buttonSearch(70)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-30-[field(200)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-5-[image(20)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:[border(1)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[image]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[button]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[field]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[buttonSearch]-0-|",
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
    
    fileprivate func performSearch()
    {
        let text:String = field.text!
        
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.background).async
        { [weak self] in
            
            self?.controller.viewCreate.map.searchLocation(text)
        }
    }
    
    //MARK: field delegate
    
    func textFieldShouldReturn(_ textField:UITextField) -> Bool
    {
        textField.resignFirstResponder()
        performSearch()
        
        return true
    }
}
