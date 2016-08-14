import UIKit

class VCreate:UIView
{
    weak var controller:CCreate!
    private let kMapHeight:CGFloat = 200
    
    convenience init(controller:CCreate)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.whiteColor()
    }
}