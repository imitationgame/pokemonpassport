import UIKit

class CHome:CMainController
{
    weak var viewHome:VHome!
    
    override func viewDidAppear(animated:Bool)
    {
        super.viewDidAppear(animated)
        
        print("home did appear")
    }
    
    override func loadView()
    {
        let viewHome:VHome = VHome(controller:self)
        self.viewHome = viewHome
        view = viewHome
    }
}