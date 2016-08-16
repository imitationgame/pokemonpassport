import Foundation

class MProjectsDetailSection
{
    let title:String
    let items:[MProjectsDetailItem]
    
    init(title:String, items:[MProjectsDetailItem])
    {
        self.title = title
        self.items = items
    }
}