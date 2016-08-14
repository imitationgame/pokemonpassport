import UIKit

class VMainLoader:UIImageView
{
    private let kAnimationDuration:NSTimeInterval = 1.5
    
    init()
    {
        super.init(frame:CGRectZero)
        
        let images:[UIImage] = [
        ]
        
        userInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        animationDuration = kAnimationDuration
        animationImages = images
        contentMode = UIViewContentMode.Center
        
        startAnimating()
    }
    
    required init?(coder aDecoder:NSCoder)
    {
        fatalError()
    }
}