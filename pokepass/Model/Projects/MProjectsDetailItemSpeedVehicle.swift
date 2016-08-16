import Foundation

class MProjectsDetailItemSpeedVehicle:MProjectsDetailItemSpeed
{
    private let kMaxDistance:Double = 0.00015
    
    init()
    {
        let title:String = NSLocalizedString("MProjectsDetailItemSpeedVehicle_title", comment:"")
        super.init(title:title, maxDistance:kMaxDistance)
    }
}