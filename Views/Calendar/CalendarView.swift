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
    @State private var showInfo: Bool = false
    
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
            .frame(maxWidth: 325)
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            
            Divider()
            
            Text("Select a day to view a headache.")
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.secondary)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .navigationTitle("Calendar")
        .onChange(of: selectedDate) {
            showInfo = true
        }
        .sheet(isPresented: $showInfo) {
            NavigationStack {
                ScrollView {
                    ForEach(headachesForSelectedDay) { headache in
                        HeadacheView(headacheToView: headache)
                            .padding(.horizontal)
                            .padding(.top)
                            .frame(maxWidth: 400)
                            .background(Color(.systemGray6))
                    //         TODO: cornerRadius is deprecated
                            .cornerRadius(16)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    }
                }
                .navigationTitle("Headaches")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Close") {
                            showInfo = false
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CalendarView()
}
