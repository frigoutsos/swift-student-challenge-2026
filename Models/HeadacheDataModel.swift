//
//  HeadacheDataModel.swift
//  headacheapp
//
//  This is the SwiftUI data model that represents all headache objects.
//
//  Created by Franklin Rigoutsos on 1/27/26.
//
import SwiftUI
import SwiftData

@Model
class Headache {
    var onsetDateAndTime: Date
    var intensity: Double
    var locations: [HeadacheLocation]
    var triggers: [HeadacheTrigger]
    
    init(
        onsetDateAndTime: Date,
        intensity: Double,
        locations: [HeadacheLocation],
        triggers: [HeadacheTrigger]
    ) {
        self.onsetDateAndTime = onsetDateAndTime
        self.intensity = intensity
        self.locations = locations
        self.triggers = triggers
    }
}
