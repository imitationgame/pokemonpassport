import Foundation

class MProjectsDetail
{
    let sections:[MProjectsDetailSection]
    weak var sectionSpeed:MProjectsDetailSectionSpeed!
    
    init()
    {
        let sectionSpeed:MProjectsDetailSectionSpeed = MProjectsDetailSection.Speed()
        self.sectionSpeed = sectionSpeed
        
        sections = [
            sectionSpeed
        ]
    }
}