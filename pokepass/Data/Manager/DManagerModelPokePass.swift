import Foundation
import CoreData

class DManagerModelPokePass:DManagerModel
{
    fileprivate let kModelName:String = "DPokePassModel"
    
    init()
    {
        super.init(modelName:kModelName)
    }
}
