import Foundation

class MSettings
{
    static let sharedInstance = MSettings()
    private(set) var model:DPokePassSettings?
    
    private init()
    {
        DManager.sharedInstance.managerPokePass.fetchManagedObjects(
            DPokePassSettings.self,
            limit:1)
        { (objects) in
            
            if objects.isEmpty
            {
                self.createModel()
            }
            else
            {
                self.model = objects.first
            }
        }
    }
    
    //MARK: private
    
    private func createModel()
    {
        DManager.sharedInstance.managerPokePass.createManagedObject(
            DPokePassSettings.self)
        { (object) in
            
            self.model = object
        }
    }
}