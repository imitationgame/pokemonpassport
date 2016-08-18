import Foundation
import MapKit

class MCreateAnnotation:NSObject, MKAnnotation
{
    let coordinate:CLLocationCoordinate2D
    let reusableIdentifier:String
    var title:String?
    
    init(coordinate:CLLocationCoordinate2D)
    {
        reusableIdentifier = VCreateMapPin.reusableIdentifier()
        self.coordinate = coordinate
        title = " "
        
        super.init()
    }
    
    //MARK: public
    
    func view() -> MKAnnotationView
    {
        let view:MKAnnotationView = VCreateMapPin(annotation:self)
        
        return view
    }
}