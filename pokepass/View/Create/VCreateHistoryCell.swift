import UIKit

class VCreateHistoryCell:UICollectionViewCell
{
    private weak var labelDistance:UILabel!
    private weak var labelLatitude:UILabel!
    private weak var labelLongitude:UILabel!
    private let numberFormatter:NumberFormatter
    private let kMaxDecimal:Int = 5
    
    override init(frame:CGRect)
    {
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.maximumFractionDigits = kMaxDecimal
        
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.white

        let labelLatitude:UILabel = UILabel()
        labelLatitude.isUserInteractionEnabled = false
        labelLatitude.translatesAutoresizingMaskIntoConstraints = false
        labelLatitude.backgroundColor = UIColor.clear
        labelLatitude.font = UIFont.regular(size:11)
        labelLatitude.textColor = UIColor.black
        self.labelLatitude = labelLatitude
        
        let labelLongitude:UILabel = UILabel()
        labelLongitude.isUserInteractionEnabled = false
        labelLongitude.translatesAutoresizingMaskIntoConstraints = false
        labelLongitude.backgroundColor = UIColor.clear
        labelLongitude.font = UIFont.regular(size:11)
        labelLongitude.textColor = UIColor.black
        self.labelLongitude = labelLongitude
        
        addSubview(labelLatitude)
        addSubview(labelLongitude)
        
        let views:[String:UIView] = [
            "labelLatitude":labelLatitude,
            "labelLongitude":labelLongitude]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[labelLatitude]-10-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[labelLongitude]-10-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-20-[labelLatitude(14)]-0-[labelLongitude(14)]",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func config(model:MCreateAnnotation)
    {
        let numberLat:NSNumber = model.coordinate.latitude as NSNumber
        let numberLon:NSNumber = model.coordinate.longitude as NSNumber
        
        guard
            
            let stringLat:String = numberFormatter.string(
                from:numberLat),
            let stringLon:String = numberFormatter.string(
                from:numberLon)
        
        else
        {
            return
        }
        
        labelLatitude.text = stringLat
        labelLongitude.text = stringLon
    }
}
