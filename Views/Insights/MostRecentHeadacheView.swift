//
//  MostRecentHeadacheView.swift
//  headacheapp
//
//  This view creates a card to display a summary of lifetime headaches.
//
//  Created by Franklin Rigoutsos on 2/17/26.
//
import SwiftUI

struct MostRecentHeadacheView: View {
    let mostRecentHeadache: Headache?
    
    var body: some View {
//        VStack(alignment: .leading, spacing: 12) {
//            Label("Most Recent Headache", systemImage: "clock.fill")
//                .font(.headline)
//                .foregroundStyle(.secondary)
//            
//            VStack(alignment: .leading, spacing: 8) {
//                if let headache = mostRecentHeadache {
//                    HStack(spacing: 8) {
//                        Image(systemName: "exclamationmark.triangle.fill")
//                            .foregroundStyle(.yellow)
//                        
//                        Text("Most common trigger:")
//                            .fontWeight(.semibold)
//                        
//                        Text(headache.triggers.map { $0.rawValue }.joined(separator: ", "))
//                            .foregroundStyle(.primary)
//                    }
//                    .font(.subheadline)
//                    
//                    HStack(spacing: 8) {
//                        Image(systemName: "location.fill")
//                            .foregroundStyle(.orange)
//                        
//                        Text("Most common location:")
//                            .fontWeight(.semibold)
//                        
//                        Text(headache.locations.map { $0.rawValue }.joined(separator: ", "))
//                            .foregroundStyle(.primary)
//                    }
//                    .font(.subheadline)
//                } else {
//                    Text("No headaches to display.")
//                }
//            }
//            .frame(maxWidth: .infinity, alignment: .leading)
//            
//        }
//        .padding()
//        .background(Color(.systemGray6))
//        .clipShape(RoundedRectangle(cornerRadius: 16))
        VStack(alignment: .leading, spacing: 16) {
            // Header
            HStack(spacing: 8) {
                Label("Most Recent Headache", systemImage: "clock.arrow.circlepath")
                    .font(.headline)
                    .foregroundStyle(.secondary)
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 12) {
                if let headache = mostRecentHeadache {
                    HeadacheView(headacheToView: headache)
                } else {
                    Text("No headaches to display.")
                        .foregroundStyle(.secondary)
                        .italic()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.08), radius: 4, x: 0, y: 2)
    }
}
