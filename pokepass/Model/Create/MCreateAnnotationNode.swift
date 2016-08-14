import Foundation
import MapKit

class MCreateAnnotationNode:MCreateAnnotation
{
    init(coordinate:CLLocationCoordinate2D)
    {
        let reusableIdentifier:String = VRestaurantMainMapperAnnotationVenue.reusableIdentifier()
        super.init(coordinate:coordinate, reusableIdentifier:reusableIdentifier)
    }
    
    override func view() -> MKAnnotationView
    {
        let view:MKAnnotationView = VRestaurantMainMapperAnnotation.Venue(self)
        
        return view
    }
}