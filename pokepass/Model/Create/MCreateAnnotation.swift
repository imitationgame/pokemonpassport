import Foundation
import MapKit

class MCreateAnnotation:NSObject, MKAnnotation
{
    let coordinate:CLLocationCoordinate2D
    let reusableIdentifier:String
    
    init(coordinate:CLLocationCoordinate2D)
    {
        reusableIdentifier = VCreateMapPin.reusableIdentifier()
        self.coordinate = coordinate
        
        super.init()
    }
    
    //MARK: public
    
    func view() -> MKAnnotationView
    {
        let view:MKAnnotationView = VCreateMapPin(annotation:self)
        
        return view
    }
}