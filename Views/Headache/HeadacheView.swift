//
//  HeadacheView.swift
//  headacheapp
//
//  This view displays information about a selected headache in a compact way.
//
//  Created by Franklin Rigoutsos on 1/20/26.
//
import SwiftUI
import SwiftData

struct HeadacheView: View {
    let headacheToView: Headache
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Intensity: \(headacheToView.intensity, specifier: "%.1f")")
            Text("Date: \(headacheToView.onsetDateAndTime.formatted())")
            Text("Locations: \(headacheToView.locations.map { $0.rawValue }.joined(separator: ", "))")
            Text("Triggers: \(headacheToView.triggers.map { $0.rawValue }.joined(separator: ", "))")
        }
        .padding()
    }
}
