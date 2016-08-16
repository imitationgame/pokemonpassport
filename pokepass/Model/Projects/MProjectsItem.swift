import Foundation

class MProjectsItem
{
    let name:String
    let model:DPokePassProject
    var locations:[MProjectItemLocation]?
    
    init(model:DPokePassProject)
    {
        name = model.name!
        self.model = model
    }
    
    //MARK: private
    
    private func itemForLocation(location:DPokePassLocation)
    {
        let latitude:Double = location.latitude
        let longitude:Double = location.longitude
        
        let item:MProjectItemLocation = MProjectItemLocation(latitude:latitude, longitude:longitude)
        locations!.append(item)
    }
    
    private func pointsBetweenLocations(index:Int, locationA:DPokePassLocation?, locationB:DPokePassLocation?, maxDistance:Double)
    {
        if locationB != nil
        {
            if locationA == nil
            {
                itemForLocation(locationB!)
            }
            else
            {
                let startingLatitude:Double = locationA!.latitude
                let startingLongitude:Double = locationA!.longitude
                let endingLatitude:Double = locationB!.latitude
                let endingLongitude:Double = locationB!.longitude
                let deltaLatitude:Double = abs(startingLatitude - endingLatitude)
                let deltaLongitude:Double = abs(startingLongitude - endingLongitude)
                let maxDelta:Double
                
                if deltaLatitude > deltaLongitude
                {
                    maxDelta = deltaLatitude
                }
                else
                {
                    maxDelta = deltaLongitude
                }
                
                if maxDelta > maxDistance
                {
                    
                }
                else
                {
                    itemForLocation(locationB!)
                }
            }
            
            let newLocationA:DPokePassLocation? = locationB
            let newLocationB:DPokePassLocation?
            let countLocations:Int = model.projectLocations.count
            let nextIndex:Int = index + 1
            
            if nextIndex < countLocations
            {
                newLocationB = model.projectLocations[nextIndex]
            }
            else
            {
                newLocationB = nil
            }
            
            pointsBetweenLocations(nextIndex, locationA:newLocationA, locationB:newLocationA, maxDistance:maxDistance)
        }
    }
    
    //MARK: public
    
    func getLocations(maxDistance:Double)
    {
        locations = []
        var previousDbLocation:DPokePassLocation?
        
        for dbLocation:DPokePassLocation in model.projectLocations
        {
            let latitude:Double = dbLocation.latitude
            let longitude:Double = dbLocation.longitude
            
            if previousDbLocation == nil
            {
                previousDbLocation = dbLocation
                
            }
            else
            {
                
            }
        }
    }
}