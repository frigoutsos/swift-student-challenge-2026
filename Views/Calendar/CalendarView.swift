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
    
    @Query(sort: \Headache.onsetDateAndTime, order: .reverse)
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
    
    private var headachesLastMonth: [Headache] {
        let oneMonthAgo = Calendar.current.date(byAdding: .month, value: -1, to: Date()) ?? Date()
        
        return headaches.filter { $0.onsetDateAndTime >= oneMonthAgo }
    }
    
    var body: some View {
        VStack(spacing: 16) {
            // TODO: I want to try to make the headache view appear underneath the calendar.
            // TODO: It should show "select a day with a headache" otherwise.
            // TODO: align this properly horizontally/vertically.
            VStack(spacing: 16) {
                Text("You've had \(headachesLastMonth.count) headaches in the past month.")
                    .font(.headline)
                DatePicker(
                    "Select Date",
                    selection: $selectedDate,
                    in: ...Date(),
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
                .tint(.red)
                    
                Divider()

                GeometryReader { geo in
                    if headachesForSelectedDay.isEmpty {
                        Text("Select a day to view a headache.")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(Color.secondary)
                    } else {
                        ScrollView {
                            VStack(spacing: 12) {
                                ForEach(headachesForSelectedDay) { headache in
                                    HeadacheView(headacheToView: headache)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding()
                                }
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding()
        .navigationTitle("Calendar")
    }
}

#Preview {
    CalendarView()
}
