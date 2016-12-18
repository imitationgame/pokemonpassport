import Foundation

class MProjectsItem
{
    let name:String
    let model:DObjectProject
    var locations:[MProjectItemLocation]?
    fileprivate let kHeader:String = "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\" ?>\n"
    fileprivate let kItemGroup:String = "<gpx>\n"
    fileprivate let kItemGroupClose:String = "</gpx>"
    
    init(model:DObjectProject)
    {
        name = model.name!
        self.model = model
    }
    
    //MARK: private
    
    private func itemForLocation(location:DObjectLocation)
    {
        let latitude:Double = location.latitude
        let longitude:Double = location.longitude
        
        itemFor(latitude:latitude, longitude:longitude)
    }
    
    private func itemFor(latitude:Double, longitude:Double)
    {
        let item:MProjectItemLocation = MProjectItemLocation(latitude:latitude, longitude:longitude)
        locations!.append(item)
    }
    
    private func pointsBetweenLocations(
        index:Int,
        locationA:DObjectLocation?,
        locationB:DObjectLocation?,
        maxDistance:Double)
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
                    let difference:Double = ceil(maxDelta / maxDistance)
                    let maxSteps:Int = Int(difference) - 1
                    var sumLatitude:Double = startingLatitude
                    var sumLongitude:Double = startingLongitude
                    let unsignedIncreaseLatitude:Double = deltaLatitude / difference
                    let unsignedIncreaseLongitude:Double = deltaLongitude / difference
                    let increaseLatitude:Double
                    let increaseLongitude:Double
                    
                    if startingLatitude > endingLatitude
                    {
                        increaseLatitude = -unsignedIncreaseLatitude
                    }
                    else
                    {
                        increaseLatitude = unsignedIncreaseLatitude
                    }
                    
                    if startingLongitude > endingLongitude
                    {
                        increaseLongitude = -unsignedIncreaseLongitude
                    }
                    else
                    {
                        increaseLongitude = unsignedIncreaseLongitude
                    }
                    
                    for _:Int in 0 ..< maxSteps
                    {
                        sumLatitude += increaseLatitude
                        sumLongitude += increaseLongitude
                        
                        itemFor(latitude:sumLatitude, longitude:sumLongitude)
                    }
                }
                
                itemForLocation(locationB!)
            }
            
            let newLocationA:DObjectLocation? = locationB
            let newLocationB:DObjectLocation?
            let countLocations:Int = model.projectLocations!.count
            let nextIndex:Int = index + 1
            
            if nextIndex < countLocations
            {
                newLocationB = model.projectLocations[nextIndex] as! DObjectLocation
            }
            else
            {
                newLocationB = nil
            }
            
            pointsBetweenLocations(
                index:nextIndex,
                locationA:newLocationA,
                locationB:newLocationB,
                maxDistance:maxDistance)
        }
    }
    
    //MARK: public
    
    func getLocations(maxDistance:Double)
    {
        locations = []
        let firstLocation:DObjectLocation? = model.projectLocations?.first as? DObjectLocation
        pointsBetweenLocations(
            index:0,
            locationA:nil,
            locationB:firstLocation,
            maxDistance:maxDistance)
    }
    
    func print() -> String
    {
        var string:String = kHeader
        string += kItemGroup
        
        for location:MProjectItemLocation in locations!
        {
            string += location.print()
        }
        
        string += kItemGroupClose
        
        return string
    }
}
