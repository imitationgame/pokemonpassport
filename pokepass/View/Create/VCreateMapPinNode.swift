import UIKit
import MapKit

class VCreateMapPinNode:VCreateMapPin
{
    init(annotation:MCreateAnnotation)
    {
        let color:UIColor = UIColor.blueColor()
        let reusableIdentifier:String = VCreateMapPinNode.reusableIdentifier()
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