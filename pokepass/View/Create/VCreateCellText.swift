import UIKit

class VCreateCellText:VCreateCell
{
    weak var textView:UITextView!
    private let kMarginTextHorizontal:CGFloat = 0
    private let kMarginTextVertical:CGFloat = 5
    private let kMarginHorizontal:CGFloat = 5
    private let kMarginVertical:CGFloat = 25
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        layoutBaseTop.constant = kMarginTextVertical
        layoutBaseBottom.constant = -kMarginTextVertical
        layoutBaseRight.constant = -kMarginTextHorizontal
        layoutBaseLeft.constant = kMarginTextHorizontal
        
        let textColor:UIColor = UIColor.blackColor()
        
        let title:UILabel = UILabel()
        title.font = UIFont.regular(12)
        title.textColor = UIColor(white:0.5, alpha:1)
        title.userInteractionEnabled = false
        title.translatesAutoresizingMaskIntoConstraints = false
        title.backgroundColor = UIColor.clearColor()
        title.text = NSLocalizedString("VCreateCellText_label", comment:"")
        
        let textView:UITextView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.clipsToBounds = true
        textView.alwaysBounceVertical = true
        textView.textContainerInset = UIEdgeInsetsMake(kMarginVertical, kMarginHorizontal, kMarginVertical, kMarginHorizontal)
        textView.backgroundColor = UIColor.clearColor()
        textView.font = UIFont.regular(18)
        textView.textColor = textColor
        textView.tintColor = textColor
        textView.keyboardAppearance = UIKeyboardAppearance.Light
        textView.autocorrectionType = UITextAutocorrectionType.No
        textView.spellCheckingType = UITextSpellCheckingType.No
        textView.autocapitalizationType = UITextAutocapitalizationType.Words
        self.textView = textView
        
        base.addSubview(title)
        base.addSubview(textView)
        
        let views:[String:AnyObject] = [
            "title":title,
            "textView":textView]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[textView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-2-[textView]-2-|",
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