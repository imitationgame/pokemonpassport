import UIKit

class CSettings:CMainController
{
    let model:MSettingsMenu
    weak var viewSettings:VSettings!
 
    init()
    {
        model = MSettingsMenu()
        
        super.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func loadView()
    {
        let viewSettings:VSettings = VSettings(controller:self)
        self.viewSettings = viewSettings
        view = viewSettings
    }
}