import Foundation

class MProjectsDetailItemSpeedSlowWalk:MProjectsDetailItemSpeed
{
    private let kMaxDistance:Double = 0.00002
    
    init()
    {
        let title:String = NSLocalizedString("MProjectsDetailItemSpeedSlowWalk_title", comment:"")
        super.init(title:title, maxDistance:kMaxDistance)
    }
}