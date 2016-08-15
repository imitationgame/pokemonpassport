import Foundation

class MProjectsItem
{
    let name:String
    let model:DPokePassProject
    
    init(model:DPokePassProject)
    {
        name = model.name!
        self.model = model
    }
}