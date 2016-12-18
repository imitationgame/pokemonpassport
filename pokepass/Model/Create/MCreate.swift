import Foundation
import CoreLocation

class MCreate
{
    var locations:[MCreateAnnotation]
        
    init()
    {
        locations = []
    }
    
    //MARK: public
    
    func load(project:MProjectsItem)
    {
        var locations:[MCreateAnnotation] = []
        
        if let dbLocations:NSOrderedSet = project.model.projectLocations
        {
            for dbLocation:Any in dbLocations
            {
                guard
                
                    let dbObject:DObjectLocation = dbLocation as? DObjectLocation
                
                else
                {
                    continue
                }
                
                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2D(
                    latitude:dbObject.latitude,
                    longitude:dbObject.longitude)
                
                let location:MCreateAnnotation = MCreateAnnotation(
                    coordinate:coordinate)
                locations.append(location)
            }
        }
        
        self.locations = locations
    }
}
