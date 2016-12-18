import UIKit

class MMainTransition
{
    let animationDuration:TimeInterval
    weak var parent:CMainParent!
    weak var current:UIViewController?
    weak var next:UIViewController!
    
    class func transition(fromIndex:Int, toIndex:Int) -> MMainTransition
    {
        let scrollTransition:MMainTransition
        
        if fromIndex > toIndex
        {
            scrollTransition = MMainTransitionScrollLeft()
        }
        else
        {
            scrollTransition = MMainTransitionScrollRight()
        }
        
        return scrollTransition
    }
    
    init(animationDuration:TimeInterval)
    {
        self.animationDuration = animationDuration
    }
    
    //MARK: public
    
    func prepare(parent:CMainParent, current:UIViewController?, next:UIViewController)
    {
        self.parent = parent
        self.current = current
        self.next = next
    }
    
    func positionBefore()
    {
    }
    
    func animationBefore()
    {
    }
    
    func positionAfter()
    {
    }
    
    func animationAfter()
    {
    }
    
    func completed()
    {
    }
}
