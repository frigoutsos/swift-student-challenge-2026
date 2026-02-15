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
    @Environment(\.modelContext) private var modelContext
    @State private var selectedHeadache: Headache? = nil
    
    var body: some View {
        NavigationStack {
            VStack {
                if (headaches.isEmpty) {
                    Text("No headaches to display.")
                } else {
                    List {
                        ForEach(headaches) { headache in
                            VStack(alignment: .leading) {
                                Text(headache.onsetDateAndTime.formatted())
                                    .font(.headline)
                                Text("Intensity: \(headache.intensity, specifier: "%.1f")")
                                    .font(.subheadline)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                selectedHeadache = headache
                            }
                        }
                        .onDelete(perform: deleteItem)
                    }
                    .sheet(item: $selectedHeadache) { headache in
                        NavigationStack {
                            HeadacheView(headacheToView: headache)
                                .padding()
                                .navigationTitle("Headache Summary")
                                .navigationBarTitleDisplayMode(.inline)
                                .toolbar {
                                    ToolbarItem(placement: .topBarTrailing) {
                                        Button("Close", role: .close) {
                                            selectedHeadache = nil
                                        }
                                    }
                                }
                        }
                    }
                }
            }
            .navigationTitle("History")
        }
    }
    
    /*
     * Function to delete a headache from the list and the SwiftData model.
     */
    func deleteItem(at offsets: IndexSet) {
        for index in offsets {
            let item = headaches[index]
            modelContext.delete(item)
        }
        
        try? modelContext.save()
    }
}

#Preview {
    HistoryView()
}
