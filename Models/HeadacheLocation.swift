//
//  HeadacheLocation.swift
//  headacheapp
//
//  This is an enum to represent possible headache locations.
//
//  Created by Franklin Rigoutsos on 1/27/26.
//
enum HeadacheLocation: String, Codable, CaseIterable {
    case leftTemple = "Left Temple"
    case rightTemple = "Right Temple"
    case bothTemples = "Both Temples"
    case leftEye = "Left Eye"
    case rightEye = "Right Eye"
    case bothEyes = "Both Eyes"
    case forehead = "Forehead"
    case backHead = "Back of Head"
    case topHead = "Top of Head"
    case sinuses = "Sinuses"
    case allOver = "All Over"
    case other = "Other"
}
