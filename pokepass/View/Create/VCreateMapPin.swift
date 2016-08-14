import UIKit
import MapKit

class VCreateMapPin:MKPinAnnotationView
{
    class func Limit(annotation:MCreateAnnotation) -> MCreateAnnotation
    {
        let view:MCreateAnnotation = VRestaurantMainMapperAnnotationUser(annotation:annotation)
        
        return view
    }
    
    class func Node(annotation:MCreateAnnotation) -> MCreateAnnotation
    {
        let view:MCreateAnnotation = VRestaurantMainMapperAnnotationVenue(annotation:annotation)
        
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