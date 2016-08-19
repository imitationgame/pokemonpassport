import Foundation
import MapKit

class MCreateAnnotation:NSObject, MKAnnotation
{
    var coordinate:CLLocationCoordinate2D
    let reusableIdentifier:String
    var title:String?
    var index:Int
    
    init(coordinate:CLLocationCoordinate2D)
    {
        reusableIdentifier = VCreateMapPin.reusableIdentifier()
        self.coordinate = coordinate
        index = 0
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