import Foundation
import CoreData

class DManagerModel
{
    let saver:DManagerSaver
    fileprivate let managedObjectContext:NSManagedObjectContext
    fileprivate let kModelExtension:String = "momd"
    fileprivate let kSQLiteExtension:String = "%@.sqlite"
    
    init(modelName:String)
    {
        let modelURL:URL = Bundle.main.url(forResource: modelName, withExtension:kModelExtension)!
        let sqliteFile:String = String(format:kSQLiteExtension, modelName)
        let storeCoordinatorURL:URL = FileManager.appDirectory().appendingPathComponent(sqliteFile)!
        let managedObjectModel:NSManagedObjectModel = NSManagedObjectModel(contentsOf:modelURL)!
        let persistentStoreCoordinator:NSPersistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel:managedObjectModel)
        
        do
        {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName:nil, at:storeCoordinatorURL, options:nil)
        }
        catch{}
        
        managedObjectContext = NSManagedObjectContext(concurrencyType:NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        saver = DManagerSaver(context:managedObjectContext)
    }
    
    //MARK: public
    
    func createManagedObject<ModelType:NSManagedObject>(_ modelType:ModelType.Type, block:((ModelType) -> ())? = nil)
    {
        saver.delaySaving()
        
        managedObjectContext.perform
        { [weak self] in
            
            if self != nil
            {
                let entityDescription:NSEntityDescription = NSEntityDescription.entity(forEntityName: modelType.entityName(), in:self!.managedObjectContext)!
                let managedObject:NSManagedObject = NSManagedObject(entity:entityDescription, insertInto:self!.managedObjectContext)
                let managedGeneric:ModelType = managedObject as! ModelType
                
                block?(managedGeneric)
            }
        }
    }
    
    func fetchManagedObjects<ModelType:NSManagedObject>(_ modelType:ModelType.Type, limit:Int = 0, predicate:NSPredicate? = nil, sorters:[NSSortDescriptor]? = nil, block:(([ModelType]) -> ())? = nil)
    {
        saver.delaySaving()
        let fetchRequest:NSFetchRequest = NSFetchRequest(entityName:modelType.entityName())
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sorters
        fetchRequest.fetchLimit = limit
        
        managedObjectContext.perform
            { [weak self] in
                
                let results:[ModelType]
                
                do
                {
                    results = try self?.managedObjectContext.fetch(fetchRequest) as! [ModelType]
                }
                catch
                {
                    results = []
                }
                
                block?(results)
        }
    }
    
    func delete(_ object:NSManagedObject, block:(() -> ())? = nil)
    {
        saver.delaySaving()
        
        managedObjectContext.perform
            { [weak self] in
                
                self?.managedObjectContext.delete(object)
                
                block?()
        }
    }
    
    func untracked<ModelType:NSManagedObject>(_ modelType:ModelType.Type) -> ModelType
    {
        let entity:NSEntityDescription = NSEntityDescription.entity(forEntityName: modelType.entityName(), in:managedObjectContext)!
        let managedObject:NSManagedObject = NSManagedObject(entity:entity, insertInto:nil)
        let model:ModelType = managedObject as! ModelType
        
        return model
    }
}
