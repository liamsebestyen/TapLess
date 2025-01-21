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
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 40){
                Text("Add Levels")
                    .font(.title)
                    .foregroundStyle(Color.blue)
                    .fontWeight(.bold)
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
                
            }
            .navigationTitle("Restriction Set Up")
            
        }.padding()
        
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
                }
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
                
            }
            
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
                }
                
               
                
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
           
            
        }
    }
}

#Preview {
    Customize()
}
