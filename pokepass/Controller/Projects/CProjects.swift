import UIKit

class CProjects:CMainController
{
    let model:MProjects
    
    init()
    {
        model = MProjects()
        
        super.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func loadView()
    {
        view = VProjects(controller:self)
    }
}