import UIKit

class CProjectsDetail:CMainController
{
    weak var viewDetail:VProjectsDetail!
    
    override func loadView()
    {
        let viewDetail:VProjectsDetail = VProjectsDetail(controller:self)
        self.viewDetail = viewDetail
        view = viewDetail
    }
}
