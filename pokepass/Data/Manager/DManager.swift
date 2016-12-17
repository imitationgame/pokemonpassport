import Foundation

class DManager
{
    static let sharedInstance = DManager()
    let managerPokePass:DManagerModelPokePass
    
    fileprivate init()
    {
        managerPokePass = DManagerModelPokePass()
    }
}
