import UIKit

class MProjectsDetailItemSpeed:MProjectsDetailItem
{
    let index:Int
    let title:String
    let maxDistance:Double
    private let kCellHeight:CGFloat = 48
    
    init(index:Int, title:String, maxDistance:Double)
    {
        self.index = index
        self.title = title
        self.maxDistance = maxDistance
        let reusableIdentifier:String = VProjectsDetailCellDistance.reusableIdentifier()
        
        super.init(reusableIdentifier:reusableIdentifier, cellHeight:kCellHeight)
    }
}