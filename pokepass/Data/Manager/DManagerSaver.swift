import Foundation
import CoreData

class DManagerSaver
{
    weak var context:NSManagedObjectContext!
    weak var timer:NSTimer?
    private let kTimeoutSave:NSTimeInterval = 1
    
    init(context:NSManagedObjectContext)
    {
        self.context = context
    }
    
    @objc func timerDone(sender timer:NSTimer)
    {
        timer.invalidate()
        self.timer = nil
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0))
        { [weak self] in
            
            self?.actualSave()
        }
    }
    
    //MARK: private
    
    private func actualSave()
    {
        if context.hasChanges
        {
            context.performBlock
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
    
    func save(force:Bool)
    {
        if force
        {
            clearTimer()
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0))
            { [weak self] in
                
                self?.actualSave()
            }
        }
        else
        {
            dispatch_async(dispatch_get_main_queue())
            { [weak self] in
                
                self?.timer?.invalidate()
                
                if self != nil
                {
                    self!.timer = NSTimer.scheduledTimerWithTimeInterval(self!.kTimeoutSave, target:self!, selector:#selector(self!.timerDone(sender:)), userInfo:nil, repeats:false)
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
        dispatch_async(dispatch_get_main_queue())
        { [weak self] in
            
            self?.timer?.invalidate()
        }
    }
}