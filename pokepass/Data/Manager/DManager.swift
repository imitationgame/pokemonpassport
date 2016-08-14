import Foundation

class DManager
{
    static let sharedInstance = DManager()
    let managerInfra:DManagerModelInfra
    
    private init()
    {
        managerInfra = DManagerModelInfra()
    }
}