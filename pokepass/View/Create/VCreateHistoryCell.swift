import UIKit
import CoreLocation

class VCreateHistoryCell:UICollectionViewCell
{
    private weak var labelDistance:UILabel!
    private weak var labelLatitude:UILabel!
    private weak var labelLongitude:UILabel!
    private weak var labelIndex:UILabel!
    private let numberFormatter:NumberFormatter
    private let distanceFormatter:NumberFormatter
    private let kKiloMeter:Double = 0.001
    private let kMile:Double = 0.000621371
    private let kMaxDecimal:Int = 7
    private let kMaxDistanceDecimal:Int = 2
    private let kEmpty:String = ""
    
    override init(frame:CGRect)
    {
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.maximumFractionDigits = kMaxDecimal
        
        distanceFormatter = NumberFormatter()
        distanceFormatter.numberStyle = NumberFormatter.Style.decimal
        distanceFormatter.maximumFractionDigits = kMaxDistanceDecimal
        
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.white

        let labelIndex:UILabel = UILabel()
        labelIndex.isUserInteractionEnabled = false
        labelIndex.translatesAutoresizingMaskIntoConstraints = false
        labelIndex.backgroundColor = UIColor.clear
        labelIndex.font = UIFont.bold(size:11)
        labelIndex.textColor = UIColor.main
        self.labelIndex = labelIndex
        
        let labelDistance:UILabel = UILabel()
        labelDistance.isUserInteractionEnabled = false
        labelDistance.translatesAutoresizingMaskIntoConstraints = false
        labelDistance.backgroundColor = UIColor.clear
        labelDistance.font = UIFont.medium(size:14)
        labelDistance.textColor = UIColor(
            red:0.55,
            green:0.7,
            blue:0,
            alpha:1)
        self.labelDistance = labelDistance
        
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
        
        addSubview(labelIndex)
        addSubview(labelLatitude)
        addSubview(labelLongitude)
        addSubview(labelDistance)
        
        let views:[String:UIView] = [
            "labelLatitude":labelLatitude,
            "labelLongitude":labelLongitude,
            "labelIndex":labelIndex,
            "labelDistance":labelDistance]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-8-[labelIndex(50)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-8-[labelDistance]-2-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-8-[labelLatitude]-2-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-8-[labelLongitude]-2-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-4-[labelIndex(14)]-0-[labelDistance(20)]-0-[labelLatitude(12)]-0-[labelLongitude(12)]",
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
        let latitude:CLLocationDegrees = model.coordinate.latitude
        let longitude:CLLocationDegrees = model.coordinate.longitude
        let numberIndex:NSNumber = index as NSNumber
        let numberLat:NSNumber = latitude as NSNumber
        let numberLon:NSNumber = longitude as NSNumber
        
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
        
        if let previous:CLLocationCoordinate2D = modelPrevious?.coordinate
        {
            let location:CLLocation = CLLocation(
                latitude:latitude,
                longitude:longitude)
            let locationPrev:CLLocation = CLLocation(
                latitude:previous.latitude,
                longitude:previous.longitude)
            let distance:CLLocationDistance = location.distance(from:locationPrev)
            let distanceShort:Double
            let name:String
            
            if MSettings.sharedInstance.model?.measures == MSettings.Measures.metric.rawValue
            {
                name = NSLocalizedString("VCreateHistoryCell_km", comment:"")
                distanceShort = distance * kKiloMeter
            }
            else
            {
                name = NSLocalizedString("VCreateHistoryCell_mile", comment:"")
                distanceShort = distance * kMile
            }
            
            let distanceNum:NSNumber = distanceShort as NSNumber
            
            guard
            
                let distanceString:String = distanceFormatter.string(
                    from:distanceNum)
            
            else
            {
                labelDistance.text = kEmpty
                
                return
            }
            
            let completeString:String = "+\(distanceString) \(name)"
            labelDistance.text = completeString
        }
        else
        {
            labelDistance.text = kEmpty
        }
    }
}
