//
//  App.swift
//  headacheapp
//
//  This contains the App's top level logic.
//
//  Created by Franklin Rigoutsos on 1/20/26.
//
import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Headache.self)
    }
}
