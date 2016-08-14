import Foundation

class MMainNavPos
{
    class func Normal() -> MMainNavPosNormal
    {
        let pos:MMainNavPosNormal = MMainNavPosNormal()
        
        return pos
    }
    
    class func Pushed() -> MMainNavPosPushed
    {
        let pos:MMainNavPosPushed = MMainNavPosPushed()
        
        return pos
    }
    
    //MARK: public
    
    func adjust(bar:VMainBar)
    {
    }
}