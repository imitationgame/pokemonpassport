import Foundation

class MProjectsDetailItemSpeedRun:MProjectsDetailItemSpeed
{
    private let kMaxDistance:Double = 0.00007
    
    init(index:Int)
    {
        let title:String = NSLocalizedString("MProjectsDetailItemSpeedRun_title", comment:"")
        super.init(index:index, title:title, maxDistance:kMaxDistance)
    }
}