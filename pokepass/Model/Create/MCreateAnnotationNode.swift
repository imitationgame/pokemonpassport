import Foundation
import MapKit

class MCreateAnnotationNode:MCreateAnnotation
{
    init(coordinate:CLLocationCoordinate2D)
    {
        let reusableIdentifier:String = VCreateMapPinNode.reusableIdentifier()
        super.init(coordinate:coordinate, reusableIdentifier:reusableIdentifier)
    }
    
    override func view() -> MKAnnotationView
    {
        let view:MKAnnotationView = VCreateMapPin.Node(self)
        
        return view
    }
}