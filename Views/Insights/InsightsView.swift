//
//  InsightsView.swift
//  headacheapp
//
//  This view displays headache insights to the user.
//
//  Created by Franklin Rigoutsos on 1/20/26.
//
import SwiftUI
import SwiftData

struct InsightsView: View {
    @Query(sort: \Headache.onsetDateAndTime, order: .reverse)
    private var headaches: [Headache]
    
    private var headachesLastMonth: [Headache] {
        let oneMonthAgo = Calendar.current.date(byAdding: .month, value: -1, to: Date()) ?? Date()
        
        return headaches.filter { $0.onsetDateAndTime >= oneMonthAgo }
    }
    
    var body: some View {
        VStack {
            Text("You've had \(headachesLastMonth.count) headaches in the past month.")
        }
        .navigationTitle("Insights")
    }
}

#Preview {
    InsightsView()
}
