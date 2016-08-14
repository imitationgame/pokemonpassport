import UIKit

class MMainNavPosPushed:MMainNavPos
{
    override func adjust(bar:VMainBar)
    {
        let width:CGFloat = -bar.bounds.maxX
        bar.layoutCollectionLeft.constant = width
        bar.layoutCollectionRight.constant = width
        bar.layoutBackLeft.constant = 0
        bar.layoutBackRight.constant = 0
    }
}