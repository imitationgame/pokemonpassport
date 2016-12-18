import UIKit
import MapKit

class VCreateMapPin:MKAnnotationView
{
    enum Callout:Int
    {
        case delete
        case move
    }
    
    private let kImageWidth:CGFloat = 40
    private let kImageHeight:CGFloat = 40
    
    init(annotation:MCreateAnnotation)
    {
        let reuseIdentifier:String = VCreateMapPin.reusableIdentifier
        let offsetY:CGFloat = kImageHeight / -2
        let leftCallOut:UIButton = UIButton(frame:CGRect(x: 0, y: 0, width: 30, height: 30))
        leftCallOut.setImage(UIImage(named:"mapAnnotationDelete"), for:UIControlState())
        leftCallOut.imageView?.contentMode = UIViewContentMode.center
        leftCallOut.imageView?.clipsToBounds = true
        leftCallOut.tag = Callout.delete.rawValue
        
        let rightCallOut:UIButton = UIButton(frame:CGRect(x: 0, y: 0, width: 30, height: 30))
        rightCallOut.setImage(UIImage(named:"mapAnnotationMove"), for:UIControlState())
        rightCallOut.imageView?.contentMode = UIViewContentMode.center
        rightCallOut.imageView?.clipsToBounds = true
        rightCallOut.tag = Callout.move.rawValue
        
        super.init(annotation:annotation, reuseIdentifier:reuseIdentifier)
        canShowCallout = true
        image = UIImage(named:"mapAnnotation")
        centerOffset = CGPoint(x: 0, y: offsetY)
        leftCalloutAccessoryView = leftCallOut
        rightCalloutAccessoryView = rightCallOut
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
