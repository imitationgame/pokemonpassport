import Foundation
import CoreData

class DManagerSaver
{
    weak var context:NSManagedObjectContext!
    weak var timer:Timer?
    fileprivate let kTimeoutSave:TimeInterval = 1
    
    init(context:NSManagedObjectContext)
    {
        self.context = context
    }
    
    @objc func timerDone(sender timer:Timer)
    {
        timer.invalidate()
        self.timer = nil
        
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.background).async
        { [weak self] in
            
            self?.actualSave()
        }
    }
    
    //MARK: private
    
    fileprivate func actualSave()
    {
        if context.hasChanges
        {
            context.perform
                { [weak self] in
                    
                    do
                    {
                        try self?.context.save()
                    }
                    catch{}
            }
        }
    }
    
    //MARK: public
    
    func save(_ force:Bool)
    {
        if force
        {
            clearTimer()
            
            DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.background).async
            { [weak self] in
                
                self?.actualSave()
            }
        }
        else
        {
            DispatchQueue.main.async
            { [weak self] in
                
                self?.timer?.invalidate()
                
                if self != nil
                {
                    self!.timer = Timer.scheduledTimer(timeInterval: self!.kTimeoutSave, target:self!, selector:#selector(self!.timerDone(sender:)), userInfo:nil, repeats:false)
                }
            }
        }
    }
    
    func delaySaving()
    {
        if timer != nil
        {
            save(false)
        }
    }
    
    func clearTimer()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.timer?.invalidate()
        }
    }
}
