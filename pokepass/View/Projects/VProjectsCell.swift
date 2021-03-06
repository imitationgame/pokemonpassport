import UIKit
import CoreLocation

class VProjectsCell:UICollectionViewCell
{
    private weak var model:MProjectsItem?
    private weak var controller:CProjects?
    private weak var label:UILabel!
    private weak var labelDistance:UILabel!
    private weak var labelPoints:UILabel!
    private let numberFormatter:NumberFormatter
    private let kMaxDecimal:Int = 3
    private let kKiloMeter:Double = 0.001
    private let kMile:Double = 0.000621371
    
    override init(frame:CGRect)
    {
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.maximumFractionDigits = kMaxDecimal
        
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor(white:1, alpha:0.9)
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.medium(size:17)
        label.textColor = UIColor.main
        self.label = label
        
        let labelPoints:UILabel = UILabel()
        labelPoints.isUserInteractionEnabled = false
        labelPoints.translatesAutoresizingMaskIntoConstraints = false
        labelPoints.backgroundColor = UIColor.clear
        labelPoints.font = UIFont.regular(size:12)
        labelPoints.textColor = UIColor(white:0, alpha:0.5)
        self.labelPoints = labelPoints
        
        let labelDistance:UILabel = UILabel()
        labelDistance.isUserInteractionEnabled = false
        labelDistance.translatesAutoresizingMaskIntoConstraints = false
        labelDistance.backgroundColor = UIColor.clear
        labelDistance.font = UIFont.regular(size:12)
        labelDistance.textColor = UIColor(white:0, alpha:0.5)
        self.labelDistance = labelDistance
        
        let buttonShare:UIButton = UIButton()
        buttonShare.translatesAutoresizingMaskIntoConstraints = false
        buttonShare.setImage(
            #imageLiteral(resourceName: "projectShare").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonShare.setImage(
            #imageLiteral(resourceName: "projectShare").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonShare.imageView!.clipsToBounds = true
        buttonShare.imageView!.contentMode = UIViewContentMode.center
        buttonShare.imageView!.tintColor = UIColor.complement
        buttonShare.addTarget(
            self,
            action:#selector(self.actionShare(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let buttonEdit:UIButton = UIButton()
        buttonEdit.translatesAutoresizingMaskIntoConstraints = false
        buttonEdit.setImage(
            #imageLiteral(resourceName: "projectEdit").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonEdit.setImage(
            #imageLiteral(resourceName: "projectEdit").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonEdit.imageView!.clipsToBounds = true
        buttonEdit.imageView!.contentMode = UIViewContentMode.center
        buttonEdit.imageView!.tintColor = UIColor.complement
        buttonEdit.addTarget(
            self,
            action:#selector(self.actionEdit(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(label)
        addSubview(labelPoints)
        addSubview(labelDistance)
        addSubview(buttonShare)
        addSubview(buttonEdit)
        
        let views:[String:UIView] = [
            "label":label,
            "labelPoints":labelPoints,
            "labelDistance":labelDistance,
            "buttonShare":buttonShare,
            "buttonEdit":buttonEdit]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[label]-0-[buttonEdit]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[labelPoints]-0-[buttonEdit]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[labelDistance]-0-[buttonEdit]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[buttonEdit(70)]-0-[buttonShare(70)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[buttonShare]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[buttonEdit]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-10-[label(21)]-2-[labelPoints(15)]-0-[labelDistance(15)]",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: actions
    
    func actionShare(sender button:UIButton)
    {
        guard
            
            let model:MProjectsItem = self.model
        
        else
        {
            return
        }
        
        controller?.export(item:model)
    }
    
    func actionEdit(sender button:UIButton)
    {
        guard
            
            let model:MProjectsItem = self.model
            
        else
        {
            return
        }
        
        controller?.edit(item:model)
    }
    
    //MARK: private
    
    private func computeDistance()
    {
        guard
            
            let locations:NSOrderedSet = model?.model.projectLocations
            
        else
        {
            return
        }
        
        var amount:Double = 0
        var prevLocation:CLLocation?
        
        for item:Any in locations
        {
            guard
            
                let dbItem:DObjectLocation = item as? DObjectLocation
            
            else
            {
                continue
            }
            
            let location:CLLocation = CLLocation(
                latitude:dbItem.latitude,
                longitude:dbItem.longitude)
            
            if let previous:CLLocation = prevLocation
            {
                amount += previous.distance(from:location)
            }
            
            prevLocation = location
        }
        
        let distanceShort:Double
        let name:String
        
        if MSettings.sharedInstance.model?.measures == MSettings.Measures.metric.rawValue
        {
            name = NSLocalizedString("VProjectsCell_km", comment:"")
            distanceShort = amount * kKiloMeter
        }
        else
        {
            name = NSLocalizedString("VProjectsCell_mile", comment:"")
            distanceShort = amount * kMile
        }
        
        guard
        
            let distanceString:String = numberFormatter.string(
                from:distanceShort as NSNumber)
        
        else
        {
            return
        }
        
        let distanceComposite:String = String(
            format:name,
            distanceString)
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.labelDistance.text = distanceComposite
        }
    }
    
    //MARK: public
    
    func config(model:MProjectsItem, controller:CProjects)
    {
        self.model = model
        self.controller = controller
        label.text = model.name
        
        guard
            
            let locations:NSOrderedSet = model.model.projectLocations,
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
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.computeDistance()
        }
    }
}
