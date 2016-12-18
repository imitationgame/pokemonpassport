import UIKit

class VCreateOptionsCell:UICollectionViewCell
{
    weak var label:UILabel!
    weak var image:UIImageView!
    
    override init(frame:CGRect)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.regular(size:10)
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.center
        label.backgroundColor = UIColor.clear
        self.label = label
        
        let image:UIImageView = UIImageView()
        image.isUserInteractionEnabled = false
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = UIViewContentMode.center
        self.image = image
        
        addSubview(label)
        addSubview(image)
        
        let views:[String:UIView] = [
            "image":image,
            "label":label]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[image]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[label]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-20-[image(30)]-0-[label(13)]",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override var isSelected:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    override var isHighlighted:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    //MARK: private
    
    private func hover()
    {
        if isSelected || isHighlighted
        {
            alpha = 0.1
        }
        else
        {
            alpha = 1
        }
    }
}
