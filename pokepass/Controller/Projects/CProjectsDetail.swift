import UIKit

class CProjectsDetail:CMainController
{
    weak var viewDetail:VProjectsDetail!
    let model:MProjectsDetail
    
    init()
    {
        model = MProjectsDetail()
        
        super.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func loadView()
    {
        let viewDetail:VProjectsDetail = VProjectsDetail(controller:self)
        self.viewDetail = viewDetail
        view = viewDetail
    }
}
