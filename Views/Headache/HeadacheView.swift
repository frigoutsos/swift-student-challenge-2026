//
//  HeadacheView.swift
//  headacheapp
//
//  This view displays information about a selected headache in a compact way.
//
//  Created by Franklin Rigoutsos on 1/20/26.
//
import SwiftUI

struct HeadacheView: View {
    let headacheToView: Headache

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            // Date
            HStack(spacing: 8) {
                Image(systemName: "calendar")
                    .foregroundColor(.blue)
                Text("Date:")
                    .bold()
                Text(headacheToView.onsetDateAndTime.formatted(.dateTime.month().day().year().hour().minute()))
            }
            
            // Intensity
            HStack(spacing: 8) {
                Image(systemName: "speedometer")
                    .foregroundColor(.red)
                Text("Intensity:")
                    .bold()
                Text("\(headacheToView.intensity, specifier: "%.1f") / 10")
            }

            // Locations
            HStack(alignment: .top, spacing: 8) {
                Image(systemName: "location.fill")
                    .foregroundColor(.orange)
                    .padding(.top, 2)
                VStack(alignment: .leading, spacing: 4) {
                    Text("Locations:")
                        .bold()
                    Text(headacheToView.locations.map { $0.rawValue }.joined(separator: ", "))
                        .fixedSize(horizontal: false, vertical: true)
                }
            }

            // Triggers
            HStack(alignment: .top, spacing: 8) {
                Image(systemName: "bolt.fill")
                    .foregroundColor(.yellow)
                    .padding(.top, 2)
                VStack(alignment: .leading, spacing: 4) {
                    Text("Triggers:")
                        .bold()
                    Text(headacheToView.triggers.map { $0.rawValue }.joined(separator: ", "))
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(24)
    }
}
