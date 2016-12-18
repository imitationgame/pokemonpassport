import UIKit

class VProjectsHeader:UICollectionReusableView
{
    private weak var controller:CProjects?
    private weak var layoutButtonLeft:NSLayoutConstraint!
    private let kButtonSize:CGFloat = 60
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let buttonCreate:UIButton = UIButton()
        buttonCreate.translatesAutoresizingMaskIntoConstraints = false
        buttonCreate.clipsToBounds = true
        buttonCreate.backgroundColor = UIColor.main
        buttonCreate.setImage(
            #imageLiteral(resourceName: "navigationCreate").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.normal)
        buttonCreate.setImage(
            #imageLiteral(resourceName: "navigationCreate").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.highlighted)
        buttonCreate.imageView!.clipsToBounds = true
        buttonCreate.imageView!.contentMode = UIViewContentMode.center
        buttonCreate.imageView!.tintColor = UIColor.white
        buttonCreate.layer.cornerRadius = kButtonSize / 2
        
        let label:UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.regular(size:13)
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.center
        label.numberOfLines = 0
        label.text = NSLocalizedString("VProjectsHeader_label", comment:"")
        
        addSubview(buttonCreate)
        addSubview(label)
        
        let views:[String:UIView] = [
            "label":label,
            "buttonCreate":buttonCreate]
        
        let metrics:[String:CGFloat] = [
            "buttonSize":kButtonSize]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[label]-10-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[buttonCreate(buttonSize)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-20-[buttonCreate(buttonSize)]-0-[label(24)]",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutButtonLeft = NSLayoutConstraint(
            item:buttonCreate,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
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
        let remain:CGFloat = width - kButtonSize
        let margin:CGFloat = remain / 2.0
        
        layoutButtonLeft.constant = margin
        super.layoutSubviews()
    }
    
    //MARK: public
    
    func config(controller:CProjects)
    {
        self.controller = controller
    }
}
