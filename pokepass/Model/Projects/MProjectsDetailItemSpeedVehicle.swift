import Foundation

class MProjectsDetailItemSpeedVehicle:MProjectsDetailItemSpeed
{
    fileprivate let kMaxDistance:Double = 0.00015
    
    init(index:Int)
    {
        let title:String = NSLocalizedString("MProjectsDetailItemSpeedVehicle_title", comment:"")
        super.init(index:index, title:title, maxDistance:kMaxDistance)
    }
}
