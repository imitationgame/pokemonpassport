import UIKit
import MapKit

extension MKAnnotationView
{
    class func reusableIdentifier() -> String
    {
        let classType:AnyClass = object_getClass(self)
        
        return NSStringFromClass(classType)
    }
}