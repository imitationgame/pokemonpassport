import Foundation
import MapKit

class MCreateAnnotation:NSObject, MKAnnotation
{
    let coordinate:CLLocationCoordinate2D
    let reusableIdentifier:String
    
    class func User(coordinate:CLLocationCoordinate2D) -> MRestaurantMainMapAnnotation
    {
        let annotation:MRestaurantMainMapAnnotation = MRestaurantMainMapAnnotationUser(coordinate:coordinate)
        
        return annotation
    }
    
    class func Venue(coordinate:CLLocationCoordinate2D, name:String) -> MRestaurantMainMapAnnotation
    {
        let annotation:MRestaurantMainMapAnnotation = MRestaurantMainMapAnnotationVenue(coordinate:coordinate, name:name)
        
        return annotation
    }
    
    init(coordinate:CLLocationCoordinate2D, reusableIdentifier:String)
    {
        self.coordinate = coordinate
        self.reusableIdentifier = reusableIdentifier
        
        super.init()
    }
    
    //MARK: public
    
    func view() -> MKAnnotationView
    {
        fatalError()
    }
}