//
//  CalendarOverlay.swift
//  headacheapp
//
//  Created by Franklin Rigoutsos on 2/6/26.
//
import SwiftUI

struct CalendarOverlay: View {
    let headacheDays: Set<Date>
    
    var body: some View {
        GeometryReader{ _ in
            ForEach(Array(headacheDays), id: \.self) { date in
                Circle()
                    .fill(Color.red.opacity(0.15))
            }
        }
        .allowsHitTesting(false)
    }
}
