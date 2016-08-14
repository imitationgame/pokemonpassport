import Foundation
import CoreData

class DManagerModel
{
    let saver:DManagerSaver
    private let managedObjectContext:NSManagedObjectContext
    private let kModelExtension:String = "momd"
    private let kSQLiteExtension:String = "%@.sqlite"
    
    init(modelName:String)
    {
        let modelURL:NSURL = NSBundle.mainBundle().URLForResource(modelName, withExtension:kModelExtension)!
        let sqliteFile:String = String(format:kSQLiteExtension, modelName)
        let storeCoordinatorURL:NSURL = NSFileManager.appDirectory().URLByAppendingPathComponent(sqliteFile)
        let managedObjectModel:NSManagedObjectModel = NSManagedObjectModel(contentsOfURL:modelURL)!
        let persistentStoreCoordinator:NSPersistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel:managedObjectModel)
        
        do
        {
            try persistentStoreCoordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration:nil, URL:storeCoordinatorURL, options:nil)
        }
        catch{}
        
        managedObjectContext = NSManagedObjectContext(concurrencyType:NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        saver = DManagerSaver(context:managedObjectContext)
    }
    
    //MARK: public
    
    func createManagedObject<ModelType:NSManagedObject>(modelType:ModelType.Type, block:(ModelType -> ())? = nil)
    {
        saver.delaySaving()
        
        managedObjectContext.performBlock
        { [weak self] in
            
            if self != nil
            {
                let entityDescription:NSEntityDescription = NSEntityDescription.entityForName(modelType.entityName(), inManagedObjectContext:self!.managedObjectContext)!
                let managedObject:NSManagedObject = NSManagedObject(entity:entityDescription, insertIntoManagedObjectContext:self!.managedObjectContext)
                let managedGeneric:ModelType = managedObject as! ModelType
                
                block?(managedGeneric)
            }
        }
    }
    
    func fetchManagedObjects<ModelType:NSManagedObject>(modelType:ModelType.Type, limit:Int = 0, predicate:NSPredicate? = nil, sorters:[NSSortDescriptor]? = nil, block:([ModelType] -> ())? = nil)
    {
        saver.delaySaving()
        let fetchRequest:NSFetchRequest = NSFetchRequest(entityName:modelType.entityName())
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sorters
        fetchRequest.fetchLimit = limit
        
        managedObjectContext.performBlock
            { [weak self] in
                
                let results:[ModelType]
                
                do
                {
                    results = try self?.managedObjectContext.executeFetchRequest(fetchRequest) as! [ModelType]
                }
                catch
                {
                    results = []
                }
                
                block?(results)
        }
    }
    
    func delete(object:NSManagedObject, block:(() -> ())? = nil)
    {
        saver.delaySaving()
        
        managedObjectContext.performBlock
            { [weak self] in
                
                self?.managedObjectContext.deleteObject(object)
                
                block?()
        }
    }
    
    func untracked<ModelType:NSManagedObject>(modelType:ModelType.Type) -> ModelType
    {
        let entity:NSEntityDescription = NSEntityDescription.entityForName(modelType.entityName(), inManagedObjectContext:managedObjectContext)!
        let managedObject:NSManagedObject = NSManagedObject(entity:entity, insertIntoManagedObjectContext:nil)
        let model:ModelType = managedObject as! ModelType
        
        return model
    }
}