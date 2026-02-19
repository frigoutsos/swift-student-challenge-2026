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
                    .foregroundStyle(.blue)
                
                Text("Date:")
                    .fontWeight(.semibold)
                
                Text(headacheToView.onsetDateAndTime.formatted(.dateTime.month().day().year().hour().minute()))
                    .foregroundStyle(.primary)
            }
            .font(.subheadline)
            
            // Intensity
            HStack(spacing: 8) {
                Image(systemName: "speedometer")
                    .foregroundStyle(.red)
                
                Text("Intensity:")
                    .fontWeight(.semibold)
                
                Text("\(headacheToView.intensity, specifier: "%.1f") / 10")
                    .foregroundStyle(.primary)
            }
            .font(.subheadline)

            // Locations
            HStack(alignment: .top, spacing: 8) {
                Image(systemName: "location.fill")
                    .foregroundStyle(.orange)
                    .padding(.top, 2)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Locations:")
                        .fontWeight(.bold)
                    
                    Text(headacheToView.locations.map { $0.rawValue }.joined(separator: ", "))
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundStyle(.primary)
                }
            }
            .font(.subheadline)

            // Triggers
            HStack(alignment: .top, spacing: 8) {
                Image(systemName: "bolt.fill")
                    .foregroundStyle(.yellow)
                    .padding(.top, 2)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Triggers:")
//                        .bold()
                        .fontWeight(.semibold)
                    
                    Text(headacheToView.triggers.map { $0.rawValue }.joined(separator: ", "))
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundStyle(.primary)
                }
            }
            .font(.subheadline)
            
        }
        .fixedSize(horizontal: false, vertical: false)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
