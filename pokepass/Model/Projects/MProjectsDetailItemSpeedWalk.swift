import Foundation

class MProjectsDetailItemSpeedWalk:MProjectsDetailItemSpeed
{
    private let kMaxDistance:Double = 0.00005
    
    init()
    {
        let title:String = NSLocalizedString("MProjectsDetailItemSpeedWalk_title", comment:"")
        super.init(title:title, maxDistance:kMaxDistance)
    }
}