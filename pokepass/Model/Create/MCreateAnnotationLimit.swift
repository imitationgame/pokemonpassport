import Foundation
import MapKit

class MCreateAnnotationLimit:MCreateAnnotation
{
    init(coordinate:CLLocationCoordinate2D)
    {
        let reusableIdentifier:String = VCreateMapPinLimit.reusableIdentifier()
        super.init(coordinate:coordinate, reusableIdentifier:reusableIdentifier)
    }
    
    override func view() -> MKAnnotationView
    {
        let view:MKAnnotationView = VCreateMapPin.Limit(self)
        
        return view
    }
}