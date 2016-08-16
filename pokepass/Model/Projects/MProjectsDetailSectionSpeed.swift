import Foundation

class MProjectsDetailSectionSpeed:MProjectsDetailSection
{
    weak var selectedItem:MProjectsDetailItemSpeed!
    
    init()
    {
        let title:String = NSLocalizedString("MProjectsDetailSectionSpeed_title", comment:"")
        
        var items:[MProjectsDetailItem] = []
        
        let itemSlowWalk:MProjectsDetailItemSpeed = MProjectsDetailItemSpeedSlowWalk(index:items.count)
        items.append(itemSlowWalk)
        
        let itemWalk:MProjectsDetailItemSpeed = MProjectsDetailItemSpeedWalk(index:items.count)
        items.append(itemWalk)
        selectedItem = itemWalk
        
        let itemRun:MProjectsDetailItemSpeed = MProjectsDetailItemSpeedRun(index:items.count)
        items.append(itemRun)
        
        let itemVehicle:MProjectsDetailItemSpeed = MProjectsDetailItemSpeedVehicle(index:items.count)
        items.append(itemVehicle)
        
        super.init(title:title, items:items)
    }
}