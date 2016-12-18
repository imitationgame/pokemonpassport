import UIKit

class VCreateHistoryCell:UICollectionViewCell
{
    private weak var labelDistance:UILabel!
    private weak var labelLatitude:UILabel!
    private weak var labelLongitude:UILabel!
    private weak var labelIndex:UILabel!
    private let numberFormatter:NumberFormatter
    private let kMaxDecimal:Int = 7
    
    override init(frame:CGRect)
    {
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.maximumFractionDigits = kMaxDecimal
        
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.white

        let labelIndex:UILabel = UILabel()
        labelIndex.isUserInteractionEnabled = false
        labelIndex.translatesAutoresizingMaskIntoConstraints = false
        labelIndex.backgroundColor = UIColor.clear
        labelIndex.font = UIFont.bold(size:16)
        labelIndex.textColor = UIColor.complement
        self.labelIndex = labelIndex
        
        let labelLatitude:UILabel = UILabel()
        labelLatitude.isUserInteractionEnabled = false
        labelLatitude.translatesAutoresizingMaskIntoConstraints = false
        labelLatitude.backgroundColor = UIColor.clear
        labelLatitude.font = UIFont.regular(size:10)
        labelLatitude.textColor = UIColor.black
        self.labelLatitude = labelLatitude
        
        let labelLongitude:UILabel = UILabel()
        labelLongitude.isUserInteractionEnabled = false
        labelLongitude.translatesAutoresizingMaskIntoConstraints = false
        labelLongitude.backgroundColor = UIColor.clear
        labelLongitude.font = UIFont.regular(size:10)
        labelLongitude.textColor = UIColor.black
        self.labelLongitude = labelLongitude
        
        addSubview(labelLatitude)
        addSubview(labelLongitude)
        
        let views:[String:UIView] = [
            "labelLatitude":labelLatitude,
            "labelLongitude":labelLongitude,
            "labelIndex":labelIndex]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[labelIndex(50)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[labelLatitude]-2-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[labelLongitude]-2-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-4-[labelIndex(24)]-10-[labelLatitude(12)]-0-[labelLongitude(12)]",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func config(index:Int, model:MCreateAnnotation, modelPrevious:MCreateAnnotation?)
    {
        let numberIndex:NSNumber = index as NSNumber
        let numberLat:NSNumber = model.coordinate.latitude as NSNumber
        let numberLon:NSNumber = model.coordinate.longitude as NSNumber
        
        guard
            
            let stringIndex:String = numberFormatter.string(
                from:numberIndex),
            let stringLat:String = numberFormatter.string(
                from:numberLat),
            let stringLon:String = numberFormatter.string(
                from:numberLon)
        
        else
        {
            return
        }
        
        labelIndex.text = stringIndex
        labelLatitude.text = stringLat
        labelLongitude.text = stringLon
    }
}
