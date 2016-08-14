import Foundation

extension NSDate
{
    func beginningOfDay() -> NSDate
    {
        let calendar:NSCalendar = NSCalendar.currentCalendar()
        let calendarUnits:NSCalendarUnit = [NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day]
        let components:NSDateComponents = calendar.components(calendarUnits, fromDate:self)
        let beginning:NSDate = calendar.dateFromComponents(components)!
        
        return beginning
    }
}