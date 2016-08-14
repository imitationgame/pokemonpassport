import UIKit

extension UILocalNotification
{
    class func cancelAll()
    {
        UIApplication.sharedApplication().cancelAllLocalNotifications()
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
    
    private class func Remainder() -> UILocalNotification
    {
        let kRemainderMinHour:NSTimeInterval = 7
        let kRemainderMaxHour:NSTimeInterval = 21
        let kSecondsInterval:NSTimeInterval = 3600
        
        let now:NSDate = NSDate()
        let calendar:NSCalendar = NSCalendar.currentCalendar()
        let hour:NSTimeInterval = NSTimeInterval(calendar.component(NSCalendarUnit.Hour, fromDate:now))
        let addedSeconds:NSTimeInterval
        
        if hour > kRemainderMaxHour
        {
            let untilMidnight:NSTimeInterval = 24 - hour
            let morning:NSTimeInterval = kRemainderMinHour + 1
            let nextHourRemainder:NSTimeInterval = untilMidnight + morning
            let nextHourInSeconds:NSTimeInterval = nextHourRemainder * kSecondsInterval
            addedSeconds = nextHourInSeconds
        }
        else if hour < kRemainderMinHour
        {
            let untilMorning:NSTimeInterval = (kRemainderMinHour + 1) - hour
            let morningInSeconds:NSTimeInterval = untilMorning * kSecondsInterval
            addedSeconds = morningInSeconds
        }
        else
        {
            addedSeconds = kSecondsInterval
        }
        
        let fireDate:NSDate = NSDate.init(timeIntervalSinceNow:addedSeconds)
        
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