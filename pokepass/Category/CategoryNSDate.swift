import Foundation

extension Date
{
    func beginningOfDay() -> Date
    {
        let calendar:Calendar = Calendar.current
        let calendarUnits:NSCalendar.Unit = [NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.day]
        let components:DateComponents = (calendar as NSCalendar).components(calendarUnits, from:self)
        let beginning:Date = calendar.date(from: components)!
        
        return beginning
    }
}
