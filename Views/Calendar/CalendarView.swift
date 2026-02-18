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
    
    var body: some View {
        VStack(spacing: 0) {
            CalendarUIKitView(
                selectedDate: $selectedDate,
                headacheDays: headacheDays
            )
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxWidth: 300)
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            
            Divider()
            
            Group {
                if headachesForSelectedDay.isEmpty {
                    Text("Select a day to view a headache.")
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color.secondary)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        VStack(alignment: .center, spacing: 12) {
                            ForEach(headachesForSelectedDay) { headache in
                                HeadacheView(headacheToView: headache)
                                    .padding(32)
                                    .frame(maxWidth: 400)
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .navigationTitle("Calendar")
    }
}

#Preview {
    CalendarView()
}
