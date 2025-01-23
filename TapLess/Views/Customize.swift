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
    @State private var times : [String] = ["5s", "10s", "20s", "30s", "1m","Other"]
    
    private var options: [String] = ["None", "Time", "Math Question"]
    private var questions: [String] = ["Easy", "Moderate","Hard", "Extreme", "Engineer"]
    
    private var backgroundGradient: some View {
        LinearGradient(colors: [Color.blue.opacity(0.75), Color.purple.opacity(0.8)], startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
    }
    
    var body: some View {
        ZStack{
            backgroundGradient
            NavigationStack {
                
                Form {
                    Section(header: Text("Type")) {
                        Picker("Type", selection: $selectedType){
                            ForEach(options, id: \.self) { option in
                                Text(option).tag(option)
                            }
                            
                        }
                        .pickerStyle(.segmented)
                        
                    }
                    
                    Section(header: Text("Threshold")) {
                        Stepper("Threshold: \(threshold)", value: $threshold, in: 0 ... 100)
                    }
                }
           
                .toolbar{
                    ToolbarItem(placement: .cancellationAction){
                        Button("Cancel"){
                            showLevels = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction){
                        Button("Confirm"){
                            showLevels = false
                            showCustomize = true
                            print("User Picked: \(selectedType)")
                            
                        }
                    }
                }
            }.navigationTitle("Choose Restriction")
            
                    VStack(spacing: 40){
                        Text("Customize Restrictions")
                            .font(.title)
                            .foregroundStyle(Color.white)
                            .fontWeight(.bold)
                            .padding(.top, 25)
                        
                        Spacer()
                        Button{
                            showLevels = true
                        } label: {
                            Text("Customize")
                                .font(.title)
                                .fontWeight(.bold)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .foregroundColor(Color.white)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }.buttonStyle(.borderedProminent)
                        
                    }.background(Color.clear)
                
            }
            .background(Color.clear)
            .padding()
            
                .sheet(isPresented: $showLevels){
                    NavigationView {
                        
                        Form {
                            Section(header: Text("Type")) {
                                Picker("Type", selection: $selectedType){
                                    ForEach(options, id: \.self) { option in
                                        Text(option).tag(option)
                                    }
                                    
                                }
                                .pickerStyle(.segmented)
                                
                            }
                            
                            Section(header: Text("Threshold")) {
                                Stepper("Threshold: \(threshold)", value: $threshold, in: 0 ... 100)
                            }
                        }.scrollContentBackground(.hidden)
                        .navigationTitle("Choose Restriction")
                        .toolbar{
                            ToolbarItem(placement: .cancellationAction){
                                Button(action: { showLevels = false }){
                                    Label("Cancel", systemImage: "xmark.circle")
                                }
                                .foregroundStyle(.red)
                                
                                
                            }
                            ToolbarItem(placement: .confirmationAction){
                                Button(action: {
                                    showLevels = false
                                    showCustomize = true
                                    print("User Picked: \(selectedType)")}){
                                        
                                        Label("Confirm", systemImage: "checkmark.circle")
                                        
                                    }.foregroundColor(.green)
                            }
                        }
                        
                    }.background(Color.clear)
                    
                }
            
                .sheet(isPresented: $showCustomize){
                    NavigationView {
                        
                        Form{
                            if (selectedType == "Time") {
                                Section(header: Text("Wait duration")) {
                                    Picker("Select time to wait", selection: $timeWait){ ForEach(times , id: \.self){ time in Text(time).tag(time)
                                    }
                                        
                                    }
                                    .pickerStyle(.segmented)
                                }
                                
                            } else if (selectedType == "Math Question"){
                                Section(header: Text("Select difficulty of a math question")) {
                                    Picker("Difficulty", selection: $difficultyMathQuestion){
                                        ForEach(questions, id: \.self) {
                                            question in Text(question)
                                        }
                                    }
                                    
                                }
                            }
                        }.scrollContentBackground(.hidden)
                        
                        
                        
                        .toolbar{
                            ToolbarItem(placement: .cancellationAction){
                                Button("Cancel"){
                                    showLevels = false
                                    showCustomize = false
                                }.buttonStyle(.borderedProminent)
                            }
                            ToolbarItem(placement: .confirmationAction){
                                Button("Confirm"){
                                    showLevels = false
                                    showCustomize = false
                                    print("User Picked: \(selectedType)")
                                    
                                }.buttonStyle(.borderedProminent)
                            }
                        }
                        
                        .navigationTitle("Customize Restrictions")
                    }
                    .background(Color.clear)
                    
                }
        }
    }
}

#Preview {
    Customize()
}
