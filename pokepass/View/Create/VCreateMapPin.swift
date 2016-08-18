import UIKit
import MapKit

class VCreateMapPin:MKAnnotationView
{
    private let kImageWidth:CGFloat = 40
    private let kImageHeight:CGFloat = 40
    
    init(annotation:MCreateAnnotation)
    {
        let reuseIdentifier:String = VCreateMapPin.reusableIdentifier()
        let offsetY:CGFloat = kImageHeight / -2
        
        super.init(annotation:annotation, reuseIdentifier:reuseIdentifier)
        canShowCallout = false
        image = UIImage(named:"mapAnnotation")
        centerOffset = CGPointMake(0, offsetY)
        callouta
    }
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override var selected:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    override var highlighted:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    //MARK: private
    
    private func hover()
    {
        if selected || highlighted
        {
            alpha = 0.1
        }
        else
        {
            alpha = 1
        }
    }
}