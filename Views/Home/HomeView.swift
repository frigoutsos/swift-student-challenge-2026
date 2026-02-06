//
//  HomeView.swift
//  headacheapp
//
//  This view holds the app's home screen.
//
//  Created by Franklin Rigoutsos on 1/20/26.
//
import SwiftUI

struct HomeView: View {
    @State private var showLogger = false
    
    var body: some View {
        VStack {
            Text("Home Page")
            
            VStack {
                Button("Log Headache") {
                    showLogger = true
                }
                .padding()
                .buttonStyle(.bordered)
                .sheet(isPresented: $showLogger) {
                    LoggingView()
                }
            }
        }
        .navigationTitle("Home")
    }
}

#Preview {
    HomeView()
}
