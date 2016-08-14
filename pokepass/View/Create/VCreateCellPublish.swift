import UIKit

class VCreateCellPublish:VCreateCell
{
    weak var button:UIButton!
    weak var spinner:VMainLoader!
    weak var layoutButtonLeft:NSLayoutConstraint!
    private let kButtonWidth:CGFloat = 200
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        base.hidden = true
        
        let button:UIButton = UIButton()
        button.clipsToBounds = true
        button.backgroundColor = UIColor(white:0.96, alpha:1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 4
        button.titleLabel?.font = UIFont.bold(15)
        button.setTitleColor(UIColor.blackColor(), forState:UIControlState.Normal)
        button.setTitleColor(UIColor(white:0, alpha:0.1), forState:UIControlState.Highlighted)
        button.setTitle(NSLocalizedString("VCreateCellPublish_button", comment:""), forState:UIControlState.Normal)
        self.button = button
        
        let spinner:VMainLoader = VMainLoader()
        spinner.stopAnimating()
        self.spinner = spinner
        
        addSubview(spinner)
        addSubview(button)
        
        let views:[String:AnyObject] = [
            "button":button,
            "spinner":spinner]
        
        let metrics:[String:AnyObject] = [
            "buttonWidth":kButtonWidth]

        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:[button(buttonWidth)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-5-[button]-10-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[spinner]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[spinner]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutButtonLeft = NSLayoutConstraint(
            item:button,
            attribute:NSLayoutAttribute.Left,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Left,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutButtonLeft)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let remain:CGFloat = width - kButtonWidth
        let margin:CGFloat = remain / 2.0
        layoutButtonLeft.constant = margin
    }
    
    //MARK: public
    
    func showLoading()
    {
        spinner.startAnimating()
        button.hidden = true
    }
    
    func hideLoading()
    {
        spinner.stopAnimating()
        button.hidden = false
    }
}