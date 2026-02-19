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
    var onsetDateAndTime: Date = Date()
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
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 12) {
                    Text("Progress:")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                    
                    ProgressView(value: Double(step), total: 4)
                        .tint(.blue)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                .padding(.top, 8)
                .padding(.bottom, 48)
                
                VStack(spacing: 16) {
                    stepContent
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
            }
            .navigationTitle(navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                toolbarContent
            }
        }
    }
    
    @ViewBuilder
    private var stepContent: some View {
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
    
    private var navigationTitle: String {
        switch step {
        case 1: return "Time and Intensity"
        case 2: return "Location"
        case 3: return "Triggers"
        case 4: return "Summary"
        default: return ""
        }
    }
    
    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        if step > 1 {
            ToolbarItem(placement: .topBarLeading) {
                Button("Back") {
                    step -= 1
                }
            }
        } else {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel", role: .cancel) {
                    dismiss()
                }
            }
        }
        
        ToolbarItem(placement: .topBarTrailing) {
            if step < 4 {
                Button("Next") {
                    step += 1
                }
            } else {
                Button("Done", role: .confirm) {
                    saveHeadache()
                }
            }
        }
    }
    
    private var builtHeadache: Headache {
        Headache(
            onsetDateAndTime: input.onsetDateAndTime,
            intensity: input.intensity,
            locations: input.locations,
            triggers: input.triggers
        )
    }
    
    private func saveHeadache() {
        context.insert(builtHeadache)
        
        do {
            try context.save()
            dismiss()
        } catch {
            print("Error saving headache:", error)
        }
    }

    /*
     * When the user is on this step, they are viewing the logger.
     */
    var timeAndIntensityStep: some View {
        VStack(alignment: .leading, spacing: 28) {
            
            VStack(alignment: .leading, spacing: 12) {
                Label("When did your headache start?", systemImage: "calendar")
                    .font(.headline)
                    .foregroundStyle(.blue)
                    
                DatePicker("Time of Onset:",
                           selection: $input.onsetDateAndTime,
                           in: ...Date(),
                           displayedComponents: [.date, .hourAndMinute])

            }
            
            VStack(alignment: .leading, spacing: 16) {
                Label("How intense is your headache?", systemImage: "speedometer")
                    .font(.headline)
                    .foregroundStyle(.red)
                
                Slider(value: $input.intensity, in: 0...10, step: 0.1)
                    .tint(.red)
                
                HStack {
                    Text("Intensity")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    Spacer()
                    
                    Text("Intensity: \(input.intensity, specifier: "%.1f")")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.red)
                }
            }
        }
        .padding(24)
    }
    
    var locationStep: some View {
        VStack(alignment: .leading, spacing: 24) {
            Label("Where does your headache hurt most?", systemImage: "location.fill")
                .font(.headline)
                .foregroundStyle(.orange)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))], spacing: 12) {
                ForEach(HeadacheLocation.allCases, id: \.self) { loc in
                    Button {
                        withAnimation(.easeInOut(duration: 0.1)) {
                            // Toggle selection
                            if input.locations.contains(loc) {
                                input.locations.removeAll { $0 == loc }
                            } else {
                                input.locations.append(loc)
                            }
                        }
                    } label: {
                        Text(loc.rawValue)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundStyle(input.locations.contains(loc) ? .white : .primary)
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                            .background(input.locations.contains(loc) ? Color.orange : Color.orange.opacity(0.15))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
            }
        }
        .padding(24)
    }
    
    var triggerStep: some View {
        VStack(alignment: .leading, spacing: 24) {
            Label("What triggered your headache?", systemImage: "bolt.fill")
                .font(.headline)
                .foregroundStyle(.yellow)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))], spacing: 12) {
                ForEach(HeadacheTrigger.allCases, id: \.self) { trig in
                    Button {
                        withAnimation(.easeInOut(duration: 0.1)) {
                            // Toggle selection
                            if input.triggers.contains(trig) {
                                input.triggers.removeAll { $0 == trig }
                            } else {
                                input.triggers.append(trig)
                            }
                        }
                    } label: {
                        Text(trig.rawValue)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundStyle(input.triggers.contains(trig) ? .white : .primary)
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                            .background(input.triggers.contains(trig) ? Color.yellow : Color.yellow.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
            }
        }
        .padding(24)
    }
    
    /*
     * When the user is viewing this step, they see a summary of the headache they entered.
     */
    var summaryStep: some View {
        VStack(spacing: 20) {
            Label("Review your headache:", systemImage: "checkmark.circle.fill")
                .font(.headline)
                .foregroundStyle(.green)
            
            HeadacheView(headacheToView: builtHeadache)
                .padding(20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}
