import UIKit

class VCreate:UIView
{
    weak var controller:CCreate!
    weak var collection:UICollectionView!
    private let kHeaderHeight:CGFloat = 60
    private let kCollectionBottom:CGFloat = 120
    
    convenience init(controller:CCreate)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.whiteColor()
    }
}