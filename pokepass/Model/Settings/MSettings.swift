import Foundation

class MSettings
{
    static let sharedInstance = MSettings()
    fileprivate(set) var model:DPokePassSettings?
    
    fileprivate init()
    {
    }
    
    //MARK: private
    
    fileprivate func createModel()
    {
        DManager.sharedInstance.managerPokePass.createManagedObject(
            DPokePassSettings.self)
        { (object) in
            
            self.model = object
            
            DManager.sharedInstance.managerPokePass.saver.save(false)
        }
    }
    
    //MARK: public
    
    func load()
    {
        if model == nil
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
    }
}
