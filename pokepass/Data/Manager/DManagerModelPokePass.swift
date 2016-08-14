import Foundation
import CoreData

class DManagerModelInfra:DManagerModel
{
    private let kModelName:String = "DInfraModel"
    
    init()
    {
        super.init(modelName:kModelName)
    }
}