import Foundation

class MProjectsDetailItemSpeedFastVehicle:MProjectsDetailItemSpeed
{
    private let kMaxDistance:Double = 0.0003
    
    init(index:Int)
    {
        let title:String = NSLocalizedString("MProjectsDetailItemSpeedFastVehicle_title", comment:"")
        super.init(index:index, title:title, maxDistance:kMaxDistance)
    }
}
