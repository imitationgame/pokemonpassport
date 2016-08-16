import Foundation

class MProjectsDetailItemSpeed:MProjectsDetailItem
{
    let title:String
    let maxDistance:Double
    
    init(title:String, maxDistance:Double)
    {
        self.title = title
        self.maxDistance = maxDistance
    }
}