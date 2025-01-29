//
//  Customize.swift
//  TapLess
//
//  Created by Liam Sebestyen on 2025-01-16.
//
import SwiftUI

struct Customize: View {
    @State private var appName: String = ""
    @State private var createdRestrictions : [RestrictionRule] = []
    @State var showLevels = false
    @State var showCustomize = false
    @State private var threshold: Int = 0
    @State private var selectedType: String = "None"
    @State private var timeWait: String = "5s"
    @State private var difficultyMathQuestion: String = "Easy"
    @State private var times: [String] = ["5s", "10s", "20s", "30s", "1m"]
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
            VStack(spacing: 40) {
                Text("Restriction Set Up")
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.top, 25)
                Spacer()
                if createdRestrictions.isEmpty {
                    VStack{
                    bubbles
                    Divider()
                    Text("You currently have no restrictions\n would you like to add some?")
                        .padding(.bottom, 100)
                        .foregroundColor(.white.opacity(0.6))
                        .fontWeight(.semibold)
                        .italic()
                }
                } else {
                    ForEach(createdRestrictions){
                        restriction in
                        restrictionItemView(restriction)
                    
                    }
                       
                   
                    
                }
                
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
                NavigationView {
                    ZStack {
                        background
                        ScrollView{
                            VStack(alignment: .leading, spacing: 5){
                                Text("Which app are you wanting to restrict?").font(.title)
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                    .padding(.top, 10)
                                TextField("e.g TikTok", text: $appName)
                                    .textFieldStyle(.roundedBorder)
                                    .padding(.vertical, 4)
                                    
                            }
                            
                        VStack(spacing: 50){
                            Text("Choose Restriction")
                                .font(.title)
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .padding(.top, 10)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Type")
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .padding(.bottom, 10)
                                VStack{
                                    Picker("Type", selection: $selectedType) {
                                        ForEach(options, id: \.self) { option in
                                            Text(option).tag(option)
                                        }
                                    }.cornerRadius(10)
                                        .accentColor(.white)
                                        .pickerStyle(.segmented)
                                        .tint(.white)
                                }.cornerRadius(10)
                                    .background(Color.white.opacity(0.2))
                                
                            }
                            .padding()
                            .background(Color.white.opacity(0.12))
                            .cornerRadius(10)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Threshold: \(Int(tester))")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding(0)
                                Slider(value: $tester, in: 0...25, step: 1)
                                    .tint(.purple)
                                
                            }
                            .padding()
                            .background(Color.white.opacity(0.12))
                            .cornerRadius(10)
                            
                            if (selectedType == "Time") {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("How long do you want to wait?")
                                        .foregroundColor(.white)
                                        .font(.headline)
                                        .padding(.bottom, 10)
                                    VStack{
                                        Picker("Select Time", selection: $timeWait) {
                                            ForEach(times, id: \.self) {
                                                time in Text(time).tag(time)
                                            }
                                        }
                                            .cornerRadius(10)
                                            .pickerStyle(.segmented)
                                            .tint(.white)
                                    }
                                    .tint(.black)
                                    .background(Color.white.opacity(0.5))
                                    .cornerRadius(10)
                                   
                                    
                                }
                        
                                
                            } else if (selectedType == "Math Question"){
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("What difficulty math question would you like?")
                                        .foregroundColor(.white)
                                        .font(.headline)
                                        .padding()
                                    VStack{
                                    Picker("Difficulty", selection: $difficultyMathQuestion) {
                                        ForEach(questions, id: \.self) {
                                            question in Text(question)
                                        }
                                    }
                                        .pickerStyle(.segmented)
                                        .tint(.white)
                                }.tint(.black)
                                       
                                        .background(Color.white.opacity(0.5))
                                        .cornerRadius(6)
                                }
                                .cornerRadius(10)
                            }
                            
                            //                                Section(header: Text("Threshold").foregroundColor(.white)) {
                            //                                    Stepper("Threshold: \(threshold)", value: $threshold, in: 0...100)
                            //                                }
                        } .padding()
                    }
                        
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                                Button("Cancel") {
                                    showLevels = false
                                }.padding(5)
                                .foregroundColor(.red)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                            }
                            
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button("Confirm") {
                                    // 1) Convert the UI’s string selection to the enum
                                        let rType = mapStringToRestrictionType(selectedType)
                                           
                                        // 2) Convert the slider value to Int
                                        let thresholdVal = Int(tester)

                                        // 3) If the user picked "Time", parse waitTime
                                        var computedWaitTime: Int? = nil
                                        if rType == .wait {
                                            computedWaitTime = parseWaitTime(timeWait)
                                        }

                                        // 4) If the user picked "Math Question", store the difficulty
                                        var questionDiff: String? = nil
                                        if rType == .mathQuestion {
                                            questionDiff = difficultyMathQuestion
                                           }

                                        // 5) Create the new restriction rule
                                        let newRule = RestrictionRule(
                                            restrictionType: rType,
                                            threshold: thresholdVal,
                                            waitTime: computedWaitTime,
                                            mathQuestionDifficulty: questionDiff
                                           )

                                        // 6) Add to your array of restrictions
                                        createdRestrictions.append(newRule)

                                        showLevels = false
                                } .padding(5)
                                .foregroundColor(.green)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                            }
                            }
                            
                        }
                .presentationDetents([.large])
                .navigationBarTitleDisplayMode(.inline)
                .presentationDragIndicator(.visible)
                    }
                    
//                    .navigationTitle("Choose Restriction")
//                    .foregroundColor(.white)
//                    .foregroundStyle(Color.white)
//                    .toolbar {
//                        ToolbarItem(placement: .cancellationAction) {
//                            Button(action: { showLevels = false }) {
//                                Label("Cancel", systemImage: "xmark.circle")
//                            }
//                            .tint(.red)
//                        }
//                        ToolbarItem(placement: .confirmationAction) {
//                            Button(action: {
//                                showLevels = false
//                                showCustomize = true
//                            }) {
//                                Label("Confirm", systemImage: "checkmark.circle")
//                            }
//                            .tint(.green)
//                        }
//                    }
                }
    
    @ViewBuilder
    private func restrictionItemView(_ rule: RestrictionRule) -> some View {
        VStack(alignment: .leading, spacing: 8) {
                // App Name
//                Text(rule.appName ?? "Unknown App")
//                    .font(.title3)
//                    .fontWeight(.bold)
//                    .foregroundColor(.white)

                // Restriction Type + Threshold
                HStack {
                    Text("Type: \(rule.restrictionType.rawValue.capitalized)")
                        .foregroundColor(.white.opacity(0.8))
                    Spacer()
                    Text("Threshold: \(rule.threshold)")
                        .foregroundColor(.white.opacity(0.8))
                }

                // Wait time or math difficulty
                if rule.restrictionType == .wait {
                    let waitTime = rule.waitTime ?? 0
                    Text("Wait Time: \(waitTime) seconds")
                        .foregroundColor(.white.opacity(0.8))
                } else if rule.restrictionType == .mathQuestion {
                    let diff = rule.mathQuestionDifficulty ?? "N/A"
                    Text("Math Difficulty: \(diff)")
                        .foregroundColor(.white.opacity(0.8))
                } else {
                    Text("No Additional Restriction")
                        .foregroundColor(.white.opacity(0.4))
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white.opacity(0.1))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
            )
            .padding(.horizontal)
            .padding(.vertical, 4)
    }
    // Save restrictions once created
    private func saveRestrictions(){
        do {
            let data = try JSONEncoder().encode(createdRestrictions)
            UserDefaults.standard.set(data, forKey: "savedRestrictions")
            } catch {
                print("Error saving the restrictions: \(error)")
            }
    }
    
    private func loadRestrictions(){
        guard let savedData = UserDefaults.standard.data(forKey: "savedRestrictions") else {return}
            do {
                let decoded = try JSONDecoder().decode([RestrictionRule].self , from: savedData)
                self.createdRestrictions = decoded
            } catch {
                print("Error loading the saved restrictions: \(error)")
            }
    }
    
    
    private func mapStringToRestrictionType(_ selectedType: String) -> RestrictionType {
        switch selectedType {
        case "Time":
            return .wait
        case "Math Question":
            return .mathQuestion
        default:
            return .none
        }
    }
    private func parseWaitTime(_ timeString: String) -> Int? {
        if timeString.hasSuffix("s") {
            // "5s" -> "5"
            let value = timeString.dropLast()
            return Int(value) // e.g. "5" -> 5
        } else if timeString == "1m" {
            return 60
        } else {
            // Could be useful for later.
            return nil
        }
        // Add more logic if needed
    }

            }
//            .sheet(isPresented: $showCustomize) {
//                ZStack {
//                    purpleGradient
//                    
//                    NavigationView {
//                        ZStack {
//                           purpleGradient
//                            
//                            Form {
//                                if selectedType == "Time" {
//                                    Section(header: Text("Wait Duration").foregroundColor(.white)) {
//                                        Picker("Select Time", selection: $timeWait) {
//                                            ForEach(times, id: \.self) { time in
//                                                Text(time).tag(time)
//                                            }
//                                        }
//                                        .pickerStyle(.segmented)
//                                        .tint(.purple)
//                                    }
//                                } else if selectedType == "Math Question" {
//                                    Section(header: Text("Math Difficulty").foregroundColor(.white)) {
//                                        Picker("Difficulty", selection: $difficultyMathQuestion) {
//                                            ForEach(questions, id: \.self) { question in
//                                                Text(question)
//                                            }
//                                        }
//                                    }
//                                }
//                            }
//                            .scrollContentBackground(.hidden)
//                            .background(Color.clear)
//                        }
//                        .navigationTitle("Customize Restrictions")
//                        .toolbar {
//                            ToolbarItem(placement: .cancellationAction) {
//                                Button("Cancel") {
//                                    showCustomize = false
//                                }
//                                .tint(.red)
//                            }
//                            ToolbarItem(placement: .confirmationAction) {
//                                Button("Confirm") {
//                                    showCustomize = false
//                                }
//                                .tint(.green)
//                            }
//                        }
//                    }
//                    .background(Color.clear)
//                }
//            }
//        }
//    }


#Preview {
    Customize()
}
