//
//  Customize.swift
//  TapLess
//
//  Created by Liam Sebestyen on 2025-01-16.
//
import SwiftUI

struct Customize: View {
    @State private var editingRestriction: (appKey: String, index: Int, rule: RestrictionRule)? = nil
    @State private var appName: String = ""
    @State private var createdRestrictions : [String: [RestrictionRule]] = [:]
    @State var showLevels = false
    @State var showCustomize = false
    @State private var threshold: Int = 0
    @State private var selectedType: String = "None"
    @State private var addAppRestriction: Bool = false
    @State private var timeWait: String = "5s"
    @State private var difficultyMathQuestion: String = "Easy"
    @State private var times: [String] = ["5s", "10s", "20s", "30s", "1m"]
    @State private var tester: Double = 0.5

    
    private let options: [String] = ["None", "Time", "Math Question"]
    private let questions: [String] = ["Easy", "Moderate", "Hard", "Extreme", "Engineer"]
    
    //Would like to group the restrictions by application for the future
    //Would be good to test this with an actual running instance
    
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
    
    struct EditRestrictionView: View {
        // Initial editing values (passed in from the parent)
        let editing: (appKey: String, index: Int, rule: RestrictionRule)
        // A callback to notify the parent view of the updated rule.
        var onSave: (RestrictionRule, String) -> Void
        
        // Local state variables for each editable field:
        @State private var appName: String
        @State private var selectedType: String
        @State private var threshold: Double
        @State private var timeWait: String
        @State private var difficultyMathQuestion: String

        // Use the same arrays as before:
        private let options: [String] = ["None", "Time", "Math Question"]
        private let questions: [String] = ["Easy", "Moderate", "Hard", "Extreme", "Engineer"]

        // Initialize the state variables using the passed in rule.
        init(editing: (appKey: String, index: Int, rule: RestrictionRule), onSave: @escaping (RestrictionRule, String) -> Void) {
            self.editing = editing
            self.onSave = onSave
            // Prepopulate the fields
            _appName = State(initialValue: editing.rule.appName ?? editing.appKey)
            _selectedType = State(initialValue: {
                switch editing.rule.restrictionType {
                case .wait: return "Time"
                case .mathQuestion: return "Math Question"
                default: return "None"
                }
            }())
            _threshold = State(initialValue: Double(editing.rule.threshold))
            _timeWait = State(initialValue: editing.rule.waitTime != nil ? "\(editing.rule.waitTime!)s" : "5s")
            _difficultyMathQuestion = State(initialValue: editing.rule.mathQuestionDifficulty ?? "Easy")
        }

        var body: some View {
            ZStack {
                Color.black.ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 50) {
                        Text("Edit Restriction")
                            .font(.title)
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .padding(.top, 10)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("App Name")
                                .foregroundColor(.white)
                            TextField("Enter app name", text: $appName)
                                .padding()
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(8)
                                .foregroundColor(.white)
                        }
                        .padding()

                        // Restriction Type picker
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
                            }
                            .cornerRadius(10)
                            .accentColor(.white)
                            .pickerStyle(.segmented)
                            .tint(.white)
                            
                        }
                            .cornerRadius(10)
                            .background(Color.white.opacity(0.2))
                            
                        }
                        .padding()
                        .background(Color.white.opacity(0.12))
                        .cornerRadius(10)
                        
                        VStack(alignment: .leading) {
                            Text("Threshold: \(Int(threshold))")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(0)

                            Slider(value: $threshold, in: 0...25, step: 1)
                                .tint(.purple)
                        }
                        .padding()
                        .background(Color.white.opacity(0.12))
                        .cornerRadius(10)

                        if selectedType == "Time" {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Wait Time")
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .padding(.bottom, 10)
                                VStack{
                                Picker("Select Time", selection: $timeWait) {
                                    ForEach(["5s", "10s", "20s", "30s", "1m"], id: \.self) { time in
                                        Text(time).tag(time)
                                    }
                                }
                                .cornerRadius(10)
                                .pickerStyle(.segmented)
                                .tint(.white)
                            }
                                .background(Color.white.opacity(0.5))
                                .cornerRadius(10)
                               
                            }.padding()
                            
                        } else if selectedType == "Math Question" {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Math Question Difficulty")
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .padding()
                                VStack{
                                Picker("Difficulty", selection: $difficultyMathQuestion) {
                                    ForEach(questions, id: \.self) { question in
                                        Text(question)
                                    }
                                }
                                .pickerStyle(.segmented)
                                .tint(.white)
                                }
                                .tint(.black)
                                .background(Color.white.opacity(0.5))
                                .cornerRadius(6)
                            }
                            .cornerRadius(10)
                        }
                        
                        HStack {
                            Button("Cancel") {
                                // Dismiss the sheet by calling onSave with no changes
                                onSave(editing.rule, editing.appKey) // You might choose not to call onSave on cancel
                            }
                            .padding()
                            .foregroundColor(.red)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            
                            Button("Save") {
                                // Map string to restriction type
                                let newType: RestrictionType
                                switch selectedType {
                                case "Time": newType = .wait
                                case "Math Question": newType = .mathQuestion
                                default: newType = .none
                                }
                                
                                // Parse the wait time if necessary
                                let computedWaitTime: Int? = newType == .wait ? parseWaitTime(timeWait) : nil

                                // Create a new rule with the updated values.
                                let updatedRule = RestrictionRule(
                                    appName: appName,
                                    restrictionType: newType,
                                    threshold: Int(threshold),
                                    waitTime: computedWaitTime,
                                    mathQuestionDifficulty: newType == .mathQuestion ? difficultyMathQuestion : nil
                                )
                                
                                // Notify the parent view about the update.
                                onSave(updatedRule, appName)
                            }
                            .padding()
                            .foregroundColor(.green)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                        }
                        .padding(.bottom, 20)
                    }
                }
            }
        }
        
        // You can include your parsing function here, or make it available globally.
        private func parseWaitTime(_ timeString: String) -> Int? {
            if timeString.hasSuffix("s") {
                let value = timeString.dropLast()
                return Int(value)
            } else if timeString == "1m" {
                return 60
            } else {
                return nil
            }
        }
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
                    ScrollView {
                        ForEach(createdRestrictions.keys.sorted(), id: \.self){ appName in
                            Section(header: Text(appName)){
                                ForEach(Array((createdRestrictions[appName] ?? []).enumerated()), id: \.element.id ){ index, restriction in
                                    restrictionItemView(restriction)
                                        .onTapGesture{
                                            editingRestriction = (appKey: appName, index: index, rule: restriction)
                                        }
                                    
                                }
                                
                                
                            }
                        }
                    }
                }
                
                Button(action: {
                    showLevels = true
                    addAppRestriction = true
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
            .onAppear{
                loadRestrictions()
            }
            
        }
        .sheet(isPresented: Binding<Bool>(
            get: { editingRestriction != nil },
            set: { newValue in if !newValue { editingRestriction = nil } }
        )) {
            if let editing = editingRestriction {
                EditRestrictionView(editing: editing) { updatedRule, updatedAppKey in
                    // This is the closure that will be called on Save from the edit sheet.
                    updateRestriction(original: editing, with: updatedRule, newAppKey: updatedAppKey)
                    editingRestriction = nil
                }
            }
        }

        .sheet(isPresented: $addAppRestriction){
            NavigationView {
                
            
                ZStack{
                    background
                    //App Restriction
                    VStack(alignment: .center, spacing: 25){
                        Text("Select App to Restrict")
                            .foregroundColor(.white)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.top, 10)
                        Text("Enter the name of the app you would like to set a screen-time restriction for.")
                            .foregroundColor(.white)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .padding()
                        
                        TextField("e.g TikTok", text: $appName)
                            .padding()
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(8)
                                .foregroundColor(.white)
                                .shadow(color: .black.opacity(0.2), radius: 4, x: 2, y: 2)
                        
                    } .padding()
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
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                            Button("Cancel") {
                                appName = ""
                                showLevels = false
                                addAppRestriction = false
                            }.padding(5)
                            .foregroundColor(.red)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                        }
                        
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Next") {
                                addAppRestriction = false
                                showLevels = true
                              
                            } .padding(5)
                            .foregroundColor(.green)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                        }
                        }
            }
            .presentationDetents([.medium, .large])
        }
        .sheet(isPresented: $showLevels) {
                NavigationView {
                    ZStack {
                        background
                        ScrollView{
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
                                    } .cornerRadius(10)
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
                                            appName: appName.isEmpty ? "Default App" : appName,
                                            restrictionType: rType,
                                            threshold: thresholdVal,
                                            waitTime: computedWaitTime,
                                            mathQuestionDifficulty: questionDiff
                                           )
                                    //6) Add Key to associate with createdRestriction
                                    print(appName)
                                    print(newRule)
                                    appName = appName.lowercased()
                                        let key = appName.isEmpty ? "Default App" : appName
                                    createdRestrictions[key, default: []].append(newRule)

                                        // 7) Add to your array of restrictions
                                        saveRestrictions()
                                        // 8) Clear AppName
                                        appName = ""
                                        showLevels = false
                                } .padding(5)
                                .foregroundColor(.green)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                            }
                            }
                            
                        }
                .onDisappear{
                    appName = ""
                    selectedType = "None"
                    tester = 0.5
                }
                .presentationDetents([.large])
                .navigationBarTitleDisplayMode(.inline)
                .presentationDragIndicator(.visible)
                    }
                }
    
    @ViewBuilder
    private func restrictionItemView(_ rule: RestrictionRule) -> some View {
        VStack(alignment: .leading, spacing: 8) {
                // App Name
                Text(rule.appName ?? "Unknown App")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

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
                let decoded = try JSONDecoder().decode([String:[RestrictionRule]].self , from: savedData)
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
    
    private func updateRestriction(original: (appKey: String, index: Int, rule: RestrictionRule), with updatedRule: RestrictionRule, newAppKey: String) {
        // If the app name (which is our key) hasn’t changed, simply update the array element:
        if newAppKey == original.appKey {
            createdRestrictions[newAppKey]?[original.index] = updatedRule
        } else {
            // If the app name changes, you may need to:
            // 1. Remove the rule from the old key.
            // 2. Add it to the new key (creating the key if it doesn’t exist).
            createdRestrictions[original.appKey]?.remove(at: original.index)
            // Clean up if the array becomes empty:
            if createdRestrictions[original.appKey]?.isEmpty == true {
                createdRestrictions.removeValue(forKey: original.appKey)
            }
            createdRestrictions[newAppKey, default: []].append(updatedRule)
        }
        saveRestrictions()
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
