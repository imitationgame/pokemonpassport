import UIKit

class CSettings:CMainController
{
    weak var viewSettings:VSettings!
    
    override func loadView()
    {
        let viewSettings:VSettings = VSettings(controller:self)
        self.viewSettings = viewSettings
        view = viewSettings
    }
}