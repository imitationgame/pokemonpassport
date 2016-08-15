import Foundation

class DManager
{
    static let sharedInstance = DManager()
    let managerPokePass:DManagerModelPokePass
    
    private init()
    {
        managerPokePass = DManagerModelPokePass()
    }
}