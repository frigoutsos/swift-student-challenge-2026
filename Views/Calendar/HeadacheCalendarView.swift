//
//  HeadacheCalendarView.swift
//  headacheapp
//
//  This is a reusable SwiftUI component built on DatePicker.
//
//  Created by Franklin Rigoutsos on 2/6/26.
//
import SwiftUI

struct HeadacheCalendarView: View {
    @Binding var selectedDate: Date
    let headacheDays: Set<Date>
    
    var body: some View {
        DatePicker(
            "Select Date",
            selection: $selectedDate,
            in: ...Date(),
            displayedComponents: [.date]
        )
        .datePickerStyle(.graphical)
        .tint(.red)
        .overlay(
            CalendarOverlay(headacheDays: headacheDays)
        )
    }
}
