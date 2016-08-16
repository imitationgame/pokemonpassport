import Foundation

class MProjectsDetailItemSpeed:MProjectsDetailItem
{
    let index:Int
    let title:String
    let maxDistance:Double
    
    init(index:Int, title:String, maxDistance:Double)
    {
        self.index = index
        self.title = title
        self.maxDistance = maxDistance
    }
}