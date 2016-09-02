import UIKit
import MapKit

class VCreateMapPin:MKAnnotationView
{
    @objc enum VCreateMapPinCallout:Int
    {
        case Delete
        case Move
    }
    
    private let kImageWidth:CGFloat = 40
    private let kImageHeight:CGFloat = 40
    
    init(annotation:MCreateAnnotation)
    {
        let reuseIdentifier:String = VCreateMapPin.reusableIdentifier()
        let offsetY:CGFloat = kImageHeight / -2
        let leftCallOut:UIButton = UIButton(frame:CGRectMake(0, 0, 30, 30))
        leftCallOut.setImage(UIImage(named:"mapAnnotationDelete"), forState:UIControlState.Normal)
        leftCallOut.imageView?.contentMode = UIViewContentMode.Center
        leftCallOut.imageView?.clipsToBounds = true
        leftCallOut.tag = VCreateMapPinCallout.Delete.rawValue
        
        let rightCallOut:UIButton = UIButton(frame:CGRectMake(0, 0, 30, 30))
        rightCallOut.setImage(UIImage(named:"mapAnnotationMove"), forState:UIControlState.Normal)
        rightCallOut.imageView?.contentMode = UIViewContentMode.Center
        rightCallOut.imageView?.clipsToBounds = true
        rightCallOut.tag = VCreateMapPinCallout.Move.rawValue
        
        super.init(annotation:annotation, reuseIdentifier:reuseIdentifier)
        canShowCallout = true
        image = UIImage(named:"mapAnnotation")
        centerOffset = CGPointMake(0, offsetY)
        leftCalloutAccessoryView = leftCallOut
        rightCalloutAccessoryView = rightCallOut
    }
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}