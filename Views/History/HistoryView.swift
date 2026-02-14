//
//  HistoryView.swift
//  headacheapp
//
//  This view displays the user's headaches as a scrollable list.
//
//  Created by Franklin Rigoutsos on 2/1/26.
//
import SwiftUI
import SwiftData

struct HistoryView: View {
    @Query(sort: \Headache.onsetDateAndTime, order: .reverse) var headaches: [Headache]
    
    var body: some View {
        NavigationStack {
            List(headaches) { headache in
                VStack(alignment: .leading) {
                    Text(headache.onsetDateAndTime.formatted())
                        .font(.headline)
                    Text(headache.intensity.formatted())
                        .font(.subheadline)
                }
            }
            .navigationTitle("History")
        }
    }
}

#Preview {
    HistoryView()
}
