import UIKit

class VProjectsCell:UICollectionViewCell
{
    private weak var label:UILabel!
    private weak var labelDistance:UILabel!
    private weak var labelPoints:UILabel!
    private let numberFormatter:NumberFormatter
    private let kMaxDecimal:Int = 3
    
    override init(frame:CGRect)
    {
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.maximumFractionDigits = kMaxDecimal
        
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor(white:1, alpha:0.5)
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.medium(size:16)
        label.textColor = UIColor.main
        self.label = label
        
        let labelPoints:UILabel = UILabel()
        labelPoints.isUserInteractionEnabled = false
        labelPoints.translatesAutoresizingMaskIntoConstraints = false
        labelPoints.backgroundColor = UIColor.clear
        labelPoints.font = UIFont.medium(size:14)
        labelPoints.textColor = UIColor.main
        self.labelPoints = labelPoints
        
        addSubview(label)
        addSubview(labelPoints)
        
        let views:[String:UIView] = [
            "label":label,
            "labelPoints":labelPoints]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[label(200)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[labelPoints(200)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-10-[label(20)]-0-[labelPoints(17)]",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func config(model:MProjectsItem)
    {
        label.text = model.name
        
        guard
            
            let locations:[MProjectItemLocation] = model.locations,
            let pointsString:String = numberFormatter.string(
                from:locations.count as NSNumber)
        
        else
        {
            return
        }
        
        let pointsCompositeString:String = String(
            format:NSLocalizedString("VProjectsCell_points", comment:""),
            pointsString)
        
        labelPoints.text = pointsCompositeString
    }
}
