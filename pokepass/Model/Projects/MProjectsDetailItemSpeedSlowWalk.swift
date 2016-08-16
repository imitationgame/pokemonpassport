import Foundation

class MProjectsDetailItemSpeedSlowWalk:MProjectsDetailItemSpeed
{
    private let kMaxDistance:Double = 0.00002
    
    init(index:Int)
    {
        let title:String = NSLocalizedString("MProjectsDetailItemSpeedSlowWalk_title", comment:"")
        super.init(index:index, title:title, maxDistance:kMaxDistance)
    }
}