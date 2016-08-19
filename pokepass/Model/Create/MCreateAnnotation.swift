import Foundation
import MapKit

class MCreateAnnotation:NSObject, MKAnnotation
{
    let coordinate:CLLocationCoordinate2D
    let reusableIdentifier:String
    var title:String?
    var index:Int
    
    init(coordinate:CLLocationCoordinate2D, index:Int)
    {
        reusableIdentifier = VCreateMapPin.reusableIdentifier()
        self.coordinate = coordinate
        self.index = index
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