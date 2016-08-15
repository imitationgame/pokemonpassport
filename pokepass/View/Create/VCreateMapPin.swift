import UIKit
import MapKit

class VCreateMapPin:MKPinAnnotationView
{
    init(annotation:MCreateAnnotation)
    {
        let reuseIdentifier:String = VCreateMapPin.reusableIdentifier()
        
        super.init(annotation:annotation, reuseIdentifier:reuseIdentifier)
        pinTintColor = UIColor.main()
        animatesDrop = true
        canShowCallout = false
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