import Foundation

class MProjectsDetailItemSpeedRun:MProjectsDetailItemSpeed
{
    private let kMaxDistance:Double = 0.00007
    
    init()
    {
        let title:String = NSLocalizedString("MProjectsDetailItemSpeedRun_title", comment:"")
        super.init(title:title, maxDistance:kMaxDistance)
    }
}