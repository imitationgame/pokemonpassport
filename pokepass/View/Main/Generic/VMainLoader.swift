import UIKit

class VMainLoader:UIImageView
{
    private let kAnimationDuration:TimeInterval = 0.66
    
    init()
    {
        super.init(frame:CGRect.zero)
        
        let images:[UIImage] = [
            UIImage(named:"loader0")!,
            UIImage(named:"loader1")!,
            UIImage(named:"loader2")!,
            UIImage(named:"loader3")!,
            UIImage(named:"loader4")!,
            UIImage(named:"loader5")!,
            UIImage(named:"loader6")!,
            UIImage(named:"loader7")!,
            UIImage(named:"loader8")!,
            UIImage(named:"loader9")!
        ]
        
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        animationDuration = kAnimationDuration
        animationImages = images
        contentMode = UIViewContentMode.center
        
        startAnimating()
    }
    
    required init?(coder aDecoder:NSCoder)
    {
        fatalError()
    }
}
