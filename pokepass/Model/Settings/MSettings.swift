import Foundation

class MSettings
{
    enum Measures:Int16
    {
        case metric
        case imperial
    }
    
    static let sharedInstance = MSettings()
    private(set) var model:DObjectSettings?
    
    private init()
    {
    }
    
    //MARK: private
    
    private func createModel()
    {
        DManager.sharedInstance.createManagedObject(
            modelType:DObjectSettings.self)
        { (object:DObjectSettings) in
            
            self.model = object
            
            DManager.sharedInstance.save()
        }
    }
    
    //MARK: public
    
    func load()
    {
        if model == nil
        {
            DManager.sharedInstance.fetchManagedObjects(
                modelType:DObjectSettings.self,
                limit:1)
            { (objects:[DObjectSettings]?) in
                
                guard
                
                    let object:DObjectSettings = objects?.first
                
                else
                {
                    self.createModel()
                    return
                }
                
                self.model = object
            }
        }
    }
}
