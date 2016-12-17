import UIKit

@UIApplicationMain
class AppDelegate:UIResponder, UIApplicationDelegate
{
    var window:UIWindow?
    private weak var parent:CMainParent!

    func application(_ application:UIApplication, didFinishLaunchingWithOptions launchOptions:[UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        let window = UIWindow(frame:UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.backgroundColor = UIColor.white
        
        let parent:CMainParent = CMainParent()
        window.rootViewController = parent
        self.window = window
        
        return true
    }
}
