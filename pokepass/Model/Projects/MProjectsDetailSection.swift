import UIKit

class MProjectsDetailSection
{
    let title:String
    let items:[MProjectsDetailItem]
 
    class func Speed() -> MProjectsDetailSectionSpeed
    {
        let section:MProjectsDetailSectionSpeed = MProjectsDetailSectionSpeed()
        
        return section
    }
    
    init(title:String, items:[MProjectsDetailItem])
    {
        self.title = title
        self.items = items
    }
    
    //MARK: public
    
    func config(header:VProjectsDetailHeader)
    {
        header.label.text = title
    }
}