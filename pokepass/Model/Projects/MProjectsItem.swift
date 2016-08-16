import Foundation

class MProjectsItem
{
    let name:String
    let model:DPokePassProject
    var locations:[]
    
    init(model:DPokePassProject)
    {
        name = model.name!
        self.model = model
    }
    
    //MARK: public
    
    func getLocations()
    {
        for
    }
}