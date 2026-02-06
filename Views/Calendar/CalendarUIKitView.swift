//
//  CalendarUIKitView.swift
//  headacheapp
//
//  This handles setup of the Calendar page.
//
//  Created by Franklin Rigoutsos on 1/27/26.
//
import SwiftUI

struct CalendarUIKitView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UICalendarView {
        let calendarView = UICalendarView()
        
        calendarView.calendar = Calendar(identifier: .gregorian)
        calendarView.locale = Locale(identifier: "en_US")
                
        let dateRange = DateInterval(
            
        )
        
        calendarView.availableDateRange = dateRange
        
        return calendarView
        
        /*
         let calendarView = UICalendarView()
         let gregorianCalendar = Calendar(identifier: .gregorian)

         // Set the range to end today
         let fromDate = Calendar.current.date(byAdding: .year, value: -1, to: Date())! // Example: 1 year ago
         let toDate = Date() // Today
         let dateRange = DateInterval(start: fromDate, end: toDate)
         calendarView.availableDateRange = dateRange
         */
    }
    
    func updateUIView(_ uiView: UICalendarView, context: Context) {
        // Update selection and decorations here later.
        // TODO: recurse through all headaches in SwiftData model and decorate the related dates.
    }
}
