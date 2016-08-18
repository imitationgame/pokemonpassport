import UIKit
import MapKit

class VCreateMapPin:MKAnnotationView
{
    private let kImageWidth:CGFloat = 35
    private let kImageHeight:CGFloat = 35
    
    init(annotation:MCreateAnnotation)
    {
        let reuseIdentifier:String = VCreateMapPin.reusableIdentifier()
        let offsetY:CGFloat = kImageHeight / -2
        
        super.init(annotation:annotation, reuseIdentifier:reuseIdentifier)
        canShowCallout = false
        image = UIImage(named:"mapAnnotation")
        centerOffset = CGPointMake(0, offsetY)
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