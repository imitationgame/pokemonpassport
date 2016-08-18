import UIKit

class VCreateMapPinCallout:UIView
{
    weak var annotation:MCreateAnnotation!
    
    convenience init(annotation:MCreateAnnotation)
    {
        self.init()
        self.annotation = annotation
        backgroundColor = UIColor.redColor()
    }
}
