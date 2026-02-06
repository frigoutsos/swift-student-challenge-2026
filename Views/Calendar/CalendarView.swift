//
//  CalendarView.swift
//  headacheapp
//
//  This view displays headaches on a calendar of the current month.
//
//  Created by Franklin Rigoutsos on 1/20/26.
//
import SwiftUI

struct CalendarView: View {
    @State private var date = Date()
    
    var body: some View {
        
        // TODO: query SwiftData model to get number of headaches in the past month.
        let numHeadaches = 3
        
        VStack {
            // TODO: I want to try to make the headache view appear underneath the calendar.
            // TODO: It should show "select a day with a headache" otherwise.
            // TODO: align this properly horizontally/vertically.
            VStack {
                Text("You've had \(numHeadaches) headaches in the past month.")
                DatePicker(
                    "Start Date",
                    selection: $date,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
            }
        }.navigationTitle("Calendar")
    }
}

#Preview {
    CalendarView()
}
