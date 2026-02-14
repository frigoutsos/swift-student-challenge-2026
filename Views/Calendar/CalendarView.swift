//
//  CalendarView.swift
//  headacheapp
//
//  This view displays headaches on a calendar of the current month.
//
//  Created by Franklin Rigoutsos on 1/20/26.
//
import SwiftUI
import SwiftData

struct CalendarView: View {
    
    @Query(sort: \Headache.onsetDateAndTime, order: .forward)
    private var headaches: [Headache]
    @State private var selectedDate = Date()
    
    private var headacheDays: Set<Date> {
        Set(headaches.map {
            Calendar.current.startOfDay(for: $0.onsetDateAndTime)
        })
    }
    
    private var headachesForSelectedDay: [Headache] {
        let day = Calendar.current.startOfDay(for: selectedDate)
        return headaches.filter {
            Calendar.current.isDate($0.onsetDateAndTime, inSameDayAs: day)
        }
    }
    
    var body: some View {
        
        VStack {
            // TODO: I want to try to make the headache view appear underneath the calendar.
            // TODO: It should show "select a day with a headache" otherwise.
            // TODO: align this properly horizontally/vertically.
            VStack {
                Text("You've had \(headaches.count) headaches in the past month.")
                
                HeadacheCalendarView(
                    selectedDate: $selectedDate,
                    headacheDays: headacheDays
                )
                
                Divider()
                
                if headachesForSelectedDay.isEmpty {
                    Text("Select a day to view a headache.")
                } else {
                    List(headachesForSelectedDay) { headache in
                        Text("Intensity: \(headache.intensity)")
                    }
                    .listStyle(.plain)
                }
            }
        }
        .padding()
        .navigationTitle("Calendar")
    }
}

#Preview {
    CalendarView()
}
