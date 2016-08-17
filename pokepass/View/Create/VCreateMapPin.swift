import UIKit
import MapKit

class VCreateMapPin:MKPinAnnotationView
{
    private let kImageWidth:CGFloat = 100
    private let kImageHeight:CGFloat = 100
    
    init(annotation:MCreateAnnotation)
    {
        let reuseIdentifier:String = VCreateMapPin.reusableIdentifier()
        let offsetY:CGFloat = kImageHeight / -2
        
        super.init(annotation:annotation, reuseIdentifier:reuseIdentifier)
        animatesDrop = true
        canShowCallout = false
        image = UIImage(named:"")
        centerOffset = CGPointMake(0, offsetY)
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