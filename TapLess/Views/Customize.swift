//
//  Customize.swift
//  TapLess
//
//  Created by Liam Sebestyen on 2025-01-16.
//
import SwiftUI

struct Customize: View {
    @State var showLevels = false
    @State var showCustomize = false
    @State private var threshold: Int = 0
    @State private var selectedType: String = "None"
    @State private var timeWait: Int = 0
    @State private var difficultyMathQuestion: String = ""
    @State private var times: [String] = ["5s", "10s", "20s", "30s", "1m", "Other"]
    @State private var tester: Double = 0.5

    
    private let options: [String] = ["None", "Time", "Math Question"]
    private let questions: [String] = ["Easy", "Moderate", "Hard", "Extreme", "Engineer"]
    
    private var background : some View {
        Color.black
            .ignoresSafeArea()
    }
    private var purpleGradient: some View {
        LinearGradient(
            colors: [Color.blue.opacity(0.75), Color.purple.opacity(0.8)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
    
    private var bubbles: some View {
        Image(systemName: "bubbles.and.sparkles.fill")
            .font(.system(size: 144, weight: .black))
            .foregroundStyle(
                MeshGradient(width: 2, height: 2, points: [
                    [0, 0], [1, 0],
                    [0, 1], [1, 1]
                ], colors: [
                    .indigo, .cyan,
                    .purple, .pink
                ])
            )
    }
    
    var body: some View {
        
        ZStack {
            background
            bubbles
            VStack(spacing: 40) {
                Text("Restriction Set Up")
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.top, 25)
                
                
                Spacer()
                Text("You currently have no restrictions, add some?")
                    .padding(.bottom, 100)
                    .foregroundColor(.white.opacity(0.6))
                    .fontWeight(.semibold)
                    .italic()
                
                Button(action: {
                    showLevels = true
                }) {
                    Text("Customize")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(purpleGradient)
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
                        .padding(.bottom, 25)
                }
                
                
            }
            .padding()
            
            
        }
        
        .sheet(isPresented: $showLevels) {
            ZStack {
                purpleGradient
                
                NavigationView {
                    ZStack {
                        purpleGradient // Gradient background for the Form
                        VStack(spacing: 10){
                            VStack {
                                Section(header: Text("Type").foregroundColor(.white)) {
                                    Picker("Type", selection: $selectedType) {
                                        ForEach(options, id: \.self) { option in
                                            Text(option).tag(option)
                                        }
                                    }
                                    .pickerStyle(.segmented)
                                    .tint(.purple)
                                }
                                Spacer()
                                Text("Threshold: \(Int(tester))")
                                    .foregroundColor(.black)
                                Slider(value: $tester, in: 0...25, step: 1 ){
                                    Text("Current Value: \(tester)")
                                } minimumValueLabel: {
                                    Text("Min")
                                } maximumValueLabel: {
                                Text("Max")
                                }.tint(.purple)
                                
                                Spacer()
                                }
//                                Section(header: Text("Threshold").foregroundColor(.white)) {
//                                    Stepper("Threshold: \(threshold)", value: $threshold, in: 0...100)
//                                }
                            }
                            .scrollContentBackground(.hidden) // Ensures Form content uses a transparent background
                            .background(Color.clear) // Removes Form's default background
                        }
                        .navigationTitle("Choose Restriction")
                        .foregroundColor(.white)
                        .foregroundStyle(Color.white)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button(action: { showLevels = false }) {
                                    Label("Cancel", systemImage: "xmark.circle")
                                }
                                .tint(.red)
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button(action: {
                                    showLevels = false
                                    showCustomize = true
                                }) {
                                    Label("Confirm", systemImage: "checkmark.circle")
                                }
                                .tint(.green)
                            }
                        }}
                }
                .background(Color.clear) // Removes NavigationView's default background
                
            }
            .sheet(isPresented: $showCustomize) {
                ZStack {
                    purpleGradient
                    
                    NavigationView {
                        ZStack {
                           purpleGradient
                            
                            Form {
                                if selectedType == "Time" {
                                    Section(header: Text("Wait Duration").foregroundColor(.white)) {
                                        Picker("Select Time", selection: $timeWait) {
                                            ForEach(times, id: \.self) { time in
                                                Text(time).tag(time)
                                            }
                                        }
                                        .pickerStyle(.segmented)
                                        .tint(.purple)
                                    }
                                } else if selectedType == "Math Question" {
                                    Section(header: Text("Math Difficulty").foregroundColor(.white)) {
                                        Picker("Difficulty", selection: $difficultyMathQuestion) {
                                            ForEach(questions, id: \.self) { question in
                                                Text(question)
                                            }
                                        }
                                    }
                                }
                            }
                            .scrollContentBackground(.hidden)
                            .background(Color.clear)
                        }
                        .navigationTitle("Customize Restrictions")
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") {
                                    showCustomize = false
                                }
                                .tint(.red)
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Confirm") {
                                    showCustomize = false
                                }
                                .tint(.green)
                            }
                        }
                    }
                    .background(Color.clear)
                }
            }
        }
    }


#Preview {
    Customize()
}
