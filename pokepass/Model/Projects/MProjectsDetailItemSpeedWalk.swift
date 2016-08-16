import Foundation

class MProjectsDetailItemSpeedWalk:MProjectsDetailItemSpeed
{
    private let kMaxDistance:Double = 0.00005
    
    init(index:Int)
    {
        let title:String = NSLocalizedString("MProjectsDetailItemSpeedWalk_title", comment:"")
        super.init(index:index, title:title, maxDistance:kMaxDistance)
    }
}