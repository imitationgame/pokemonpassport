import UIKit

extension UILocalNotification
{
    class func cancelAll()
    {
        UIApplication.shared.cancelAllLocalNotifications()
    }
    
    class func postRemainder()
    {
        self.cancelAll()
        /*
        if MConfiguration.sharedInstance.device!.notifications
        {
            let notification:UILocalNotification = self.Remainder()
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
        }*/
    }
    
    //MARK: private
    
    fileprivate class func Remainder() -> UILocalNotification
    {
        let kRemainderMinHour:TimeInterval = 7
        let kRemainderMaxHour:TimeInterval = 21
        let kSecondsInterval:TimeInterval = 3600
        
        let now:Date = Date()
        let calendar:Calendar = Calendar.current
        let hour:TimeInterval = TimeInterval((calendar as NSCalendar).component(NSCalendar.Unit.hour, from:now))
        let addedSeconds:TimeInterval
        
        if hour > kRemainderMaxHour
        {
            let untilMidnight:TimeInterval = 24 - hour
            let morning:TimeInterval = kRemainderMinHour + 1
            let nextHourRemainder:TimeInterval = untilMidnight + morning
            let nextHourInSeconds:TimeInterval = nextHourRemainder * kSecondsInterval
            addedSeconds = nextHourInSeconds
        }
        else if hour < kRemainderMinHour
        {
            let untilMorning:TimeInterval = (kRemainderMinHour + 1) - hour
            let morningInSeconds:TimeInterval = untilMorning * kSecondsInterval
            addedSeconds = morningInSeconds
        }
        else
        {
            addedSeconds = kSecondsInterval
        }
        
        let fireDate:Date = Date.init(timeIntervalSinceNow:addedSeconds)
        
        let notification:UILocalNotification = UILocalNotification()
        notification.alertBody = NSLocalizedString("UILocalNotification_remainder", comment:"")
        notification.fireDate = fireDate
        
        return notification
    }
    
    
    /*
 
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 5), dispatch_get_main_queue(),
     ^
     {
     if([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)])
     {
     UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert categories:nil];
     [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
     }
     });
     
 */
}
