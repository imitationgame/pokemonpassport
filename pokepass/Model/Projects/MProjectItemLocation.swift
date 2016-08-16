import Foundation

class MProjectItemLocation
{
    let latitude:Double
    let longitude:Double
    private let kPrint:String = "<wpt lat=\"%@\" lon=\"%@\" />\n"
    
    init(latitude:Double, longitude:Double)
    {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    //MARK: public
    
    func print() -> String
    {
        let string:String = String(format:kPrint, latitude, longitude)
        
        return string
    }
}