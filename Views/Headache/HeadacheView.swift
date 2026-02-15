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
            
            // Intensity
            HStack(spacing: 8) {
                Image(systemName: "speedometer")
                    .foregroundColor(.red)
                Text("Intensity:")
                    .bold()
                Text("\(headacheToView.intensity, specifier: "%.1f") / 10")
            }

            // Date
            HStack(spacing: 8) {
                Image(systemName: "calendar")
                    .foregroundColor(.blue)
                Text("Date:")
                    .bold()
                Text(headacheToView.onsetDateAndTime.formatted(.dateTime.month().day().year().hour().minute()))
            }

            // Locations
            HStack(alignment: .top, spacing: 8) {
                Image(systemName: "location.fill")
                    .foregroundColor(.orange)
                    .padding(.top, 2) // Align icon to text
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
        .padding(24)
        .background(Color(.systemGray6))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
