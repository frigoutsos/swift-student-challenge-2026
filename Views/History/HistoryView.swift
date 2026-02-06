//
//  HistoryView.swift
//  headacheapp
//
//  This view displays the user's headaches as a scrollable list.
//
//  Created by Franklin Rigoutsos on 2/1/26.
//
import SwiftUI

struct HistoryView: View {
    var body: some View {
        
        // TODO: query SwiftData model to get list of all headaches.
        
        VStack {
            ScrollView {
                Text("History Page")
            }
        }
        .navigationTitle("History")
    }
}

#Preview {
    HistoryView()
}
