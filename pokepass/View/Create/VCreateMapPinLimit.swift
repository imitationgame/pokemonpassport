import UIKit
import MapKit

class VCreateMapPinLimit:VCreateMapPin
{
    init(annotation:MCreateAnnotation)
    {
        let color:UIColor = UIColor.greenColor()
        let reusableIdentifier:String = VCreateMapPinLimit.reusableIdentifier()
        super.init(annotation:annotation, reuseIdentifier:reusableIdentifier, color:color)
    }
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}