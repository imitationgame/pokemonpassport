import UIKit

class MMainNavPosNormal:MMainNavPos
{
    override func adjust(_ bar:VMainBar)
    {
        let width:CGFloat = bar.bounds.maxX
        bar.layoutCollectionLeft.constant = 0
        bar.layoutCollectionRight.constant = 0
        bar.layoutBackLeft.constant = width
        bar.layoutBackRight.constant = width
    }
}
