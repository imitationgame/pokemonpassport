import UIKit
import MapKit

class VCreateMapPin:MKPinAnnotationView
{
    class func Limit(annotation:MCreateAnnotation) -> VCreateMapPin
    {
        let view:VCreateMapPin = VCreateMapPinLimit(annotation:annotation)
        
        return view
    }
    
    class func Node(annotation:MCreateAnnotation) -> VCreateMapPin
    {
        let view:VCreateMapPin = VCreateMapPinNode(annotation:annotation)
        
        return view
    }
    
    init(annotation:MCreateAnnotation, reuseIdentifier:String, color:UIColor)
    {
        super.init(annotation:annotation, reuseIdentifier:reuseIdentifier)
        pinTintColor = color
        animatesDrop = true
        canShowCallout = true
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