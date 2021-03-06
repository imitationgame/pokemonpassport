import UIKit

class MProjectsDetailItemSpeed:MProjectsDetailItem
{
    let index:Int
    let title:String
    let maxDistance:Double
    private let kCellHeight:CGFloat = 44
    private let kSelectable:Bool = true
    
    init(index:Int, title:String, maxDistance:Double)
    {
        self.index = index
        self.title = title
        self.maxDistance = maxDistance
        let reusableIdentifier:String = VProjectsDetailCellSpeed.reusableIdentifier
        
        super.init(reusableIdentifier:reusableIdentifier, cellHeight:kCellHeight, selectable:kSelectable)
    }
    
    override func config(cell:VProjectsDetailCell, controller:CProjectsDetail)
    {
        let cellSpeed:VProjectsDetailCellSpeed = cell as! VProjectsDetailCellSpeed
        cellSpeed.label.text = title
        
        if controller.model.sectionSpeed.selectedItem === self
        {
            cellSpeed.backgroundColor = UIColor.white
            cellSpeed.label.textColor = UIColor.main
        }
        else
        {
            cellSpeed.backgroundColor = UIColor(white:1, alpha:0.2)
            cellSpeed.label.textColor = UIColor.main.withAlphaComponent(0.4)
        }
    }
    
    override func selected(controller:CProjectsDetail)
    {
        controller.model.sectionSpeed.selectedItem = self
        controller.viewDetail.collection.reloadData()
    }
}
