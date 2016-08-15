import Foundation
import CoreData

class DManagerModelPokePass:DManagerModel
{
    private let kModelName:String = "DPokePassModel"
    
    init()
    {
        super.init(modelName:kModelName)
    }
}