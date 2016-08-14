import UIKit

class VCreateCellTitle:VCreateCell
{
    weak var field:UITextField!
    private let kMarginTitleHorizontal:CGFloat = 0
    private let kMarginTitleVertical:CGFloat = 5
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        layoutBaseTop.constant = kMarginTitleVertical
        layoutBaseBottom.constant = -kMarginTitleVertical
        layoutBaseRight.constant = -kMarginTitleHorizontal
        layoutBaseLeft.constant = kMarginTitleHorizontal
        
        let textColor:UIColor = UIColor(white:0.1, alpha:1)
        
        let title:UILabel = UILabel()
        title.font = UIFont.regular(12)
        title.textColor = UIColor(white:0.5, alpha:1)
        title.userInteractionEnabled = false
        title.translatesAutoresizingMaskIntoConstraints = false
        title.backgroundColor = UIColor.clearColor()
        title.text = NSLocalizedString("VCreateCellTitle_label", comment:"")
        
        let field:UITextField = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.clipsToBounds = true
        field.backgroundColor = UIColor.clearColor()
        field.borderStyle = UITextBorderStyle.None
        field.font = UIFont.regular(18)
        field.textColor = textColor
        field.tintColor = textColor
        field.returnKeyType = UIReturnKeyType.Done
        field.keyboardAppearance = UIKeyboardAppearance.Light
        field.autocorrectionType = UITextAutocorrectionType.No
        field.spellCheckingType = UITextSpellCheckingType.No
        field.autocapitalizationType = UITextAutocapitalizationType.Words
        field.clearButtonMode = UITextFieldViewMode.Never
        field.placeholder = NSLocalizedString("VCreateCellTitle_fieldPlaceholder", comment:"")
        self.field = field
        
        base.addSubview(title)
        base.addSubview(field)
        
        let views:[String:AnyObject] = [
            "title":title,
            "field":field]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-10-[field]-3-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-14-[field]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-10-[title]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-5-[title]",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}