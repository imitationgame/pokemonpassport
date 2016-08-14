import Foundation
import MapKit

class MCreateAnnotation:NSObject, MKAnnotation
{
    let coordinate:CLLocationCoordinate2D
    let reusableIdentifier:String
    
    class func Node(coordinate:CLLocationCoordinate2D) -> MCreateAnnotationNode
    {
        let annotation:MCreateAnnotationNode = MCreateAnnotationNode(coordinate:coordinate)
        
        return annotation
    }
    
    class func Limit(coordinate:CLLocationCoordinate2D, name:String) -> MCreateAnnotationLimit
    {
        let annotation:MCreateAnnotationLimit = MCreateAnnotationLimit(coordinate:coordinate)
        
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