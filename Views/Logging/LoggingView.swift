//
//  LoggingView.swift
//  headacheapp
//
//  This view guides the user through logging headaches.
//
//  Created by Franklin Rigoutsos on 1/20/26.
//
import SwiftUI

/*
 * Here we make a temporary object to hold user input,
 * which will then be turned into a Headache object.
 */
struct HeadacheInput {
    var intensity: Double = 5
    var onsetDate: Date = Date()
    var locations: [HeadacheLocation] = []
    var triggers: [HeadacheTrigger] = []
}

struct LoggingView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    // Track the state of which step the user is on
    @State private var step: Int = 1
    // State of the user's input as they go through the screen
    @State private var input = HeadacheInput()
    
    
    var body: some View {
        // Change the view programatically as the user clicks through the prompts
        switch step {
        case 1:
            timeAndIntensityStep
        case 2:
            locationStep
        case 3:
            triggerStep
        case 4:
            summaryStep
        default:
            timeAndIntensityStep
        }
    }

    /*
     * When the user is on this step, they are viewing the logger.
     */
    var timeAndIntensityStep: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("When did your headache start?")
                DatePicker("Time of Onset", selection: $input.onsetDate, displayedComponents: [.date, .hourAndMinute])
                
                Text("How intense is your headache?")
                // TODO: change background based on intensity of headache
                Slider(value: $input.intensity, in: 0...10, step: 0.1)
                Text("Intensity: \(input.intensity, specifier: "%.1f")")
            }
            .padding(30)
            .navigationTitle("Time and Intensity")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Next") {
                        step += 1
                    }
                }
            }
        }
    }
    
    var locationStep: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("Where does your headache hurt the most?")
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))], spacing: 12) {
                    ForEach(HeadacheLocation.allCases, id: \.self) { loc in
                        Button(action: {
                            // Toggle selection
                            if input.locations.contains(loc) {
                                input.locations.removeAll { $0 == loc }
                            } else {
                                input.locations.append(loc)
                            }
                        }) {
                            Text(loc.rawValue)
                                .font(.subheadline)
                                .foregroundColor(input.locations.contains(loc) ? .white : .primary)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 12)
                                .frame(maxWidth: .infinity)
                                .background(input.locations.contains(loc) ? Color.blue : Color.gray.opacity(0.2))
                                // TODO: cornerRadius is deprecated
                                .cornerRadius(10)
                                // TODO: Open a text box for the other
                        }
                    }
                }
            }
            .padding(30)
            .navigationTitle("Location")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Back") {
                        step -= 1
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Next") {
                        step += 1
                    }
                }
            }
        }
    }
    
    var triggerStep: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("What do you think triggered your headache?")
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))], spacing: 12) {
                    ForEach(HeadacheTrigger.allCases, id: \.self) { trig in
                        Button(action: {
                            // Toggle selection
                            if input.triggers.contains(trig) {
                                input.triggers.removeAll { $0 == trig }
                            } else {
                                input.triggers.append(trig)
                            }
                        }) {
                            Text(trig.rawValue)
                                .font(.subheadline)
                                .foregroundColor(input.triggers.contains(trig) ? .white : .primary)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 12)
                                .frame(maxWidth: .infinity)
                                .background(input.triggers.contains(trig) ? Color.blue : Color.gray.opacity(0.2))
                                // TODO: cornerRadius is deprecated
                                .cornerRadius(10)
                        }
                    }
                }
            }
            .padding(30)
            .navigationTitle("Triggers")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Back") {
                        step -= 1
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Next") {
                        step += 1
                    }
                }
            }
        }
    }
    
    /*
     * When the user is viewing this step, they see a summary of the headache they entered.
     */
    var summaryStep: some View {
        // Navigation stack allows for
        NavigationStack {
            VStack(spacing: 16) {
                Text("Review your headache")
                Text("Intensity: \(input.intensity, specifier: "%.1f")")
                Text("Date: \(input.onsetDate.formatted())")
                Text("Locations:")
                Text("Triggers:")
//                Text("Locations: \(input.locations.map { $0.displayName }.joined(separator: ", "))")
//                Text("Triggers: \(input.triggers.map { $0.displayName }.joined(separator: ", "))")
            }
            .padding(30)
            .navigationTitle("Headache Summary")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Back") {
                        step -= 1
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done", role: .confirm) {
                        dismiss()
                        
                        let headache = Headache(
                            onsetDateAndTime: input.onsetDate,
                            intensity: input.intensity,
                            locations: input.locations,
                            triggers: input.triggers
                        )
                        context.insert(headache)
                        do {
                            try context.save()
                            dismiss()
                        } catch {
                            print("Error saving headache: \(error)")
                        }
                    }
                }
            }
        }
    }

}

#Preview {
    LoggingView()
}
