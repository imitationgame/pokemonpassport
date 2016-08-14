import UIKit

class MMainTransition
{
    let animationDuration:NSTimeInterval
    weak var parent:CMainParent!
    weak var current:UIViewController?
    weak var next:UIViewController!
    
    class func transition(fromIndex:Int, toIndex:Int) -> MMainTransition
    {
        let scrollTransition:MMainTransition
        
        if fromIndex > toIndex
        {
            scrollTransition = MMainTransition.ScrollLeft()
        }
        else
        {
            scrollTransition = MMainTransition.ScrollRight()
        }
        
        return scrollTransition
    }
    
    class func Fade() -> MMainTransition
    {
        let transition:MMainTransition = MMainTransitionFade()
        
        return transition
    }
    
    class func ScrollLeft() -> MMainTransition
    {
        let transition:MMainTransition = MMainTransitionScrollLeft()
        
        return transition
    }
    
    class func ScrollRight() -> MMainTransition
    {
        let transition:MMainTransition = MMainTransitionScrollRight()
        
        return transition
    }
    
    class func Replace() -> MMainTransition
    {
        let transition:MMainTransition = MMainTransitionReplace()
        
        return transition
    }
    
    class func Push(pushed:String) -> MMainTransition
    {
        let transition:MMainTransition = MMainTransitionPush(pushed:pushed)
        
        return transition
    }
    
    class func Pop() -> MMainTransition
    {
        let transition:MMainTransition = MMainTransitionPop()
        
        return transition
    }
    
    init(animationDuration:NSTimeInterval)
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