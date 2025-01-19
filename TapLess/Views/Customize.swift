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
    
    private var options: [String] = ["None", "Time", "Math Question"]
    
    var body: some View {
        
        
        
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
                .accentColor(Color.blue)
               
            
        }
        
        .sheet(isPresented: $showLevels){
            
            Text("Choose Restriction Type")
            Form {
                Section(header: Text("Type")) {
                    Picker("Type", selection: $selectedType){
                        ForEach(options, id: \.self) { option in
                            Text(option).tag(option)
                        }
                        
                    }
                    .pickerStyle(.segmented)
                    
                }
                
                
            }
            HStack {
                Button("Cancel") {
                    // Dismiss the sheet without saving
                    showLevels = false
                }
                .foregroundColor(.red)
                
                Spacer()
                
                Button("Save") {
                    print("User picked:", selectedType)
                    showLevels = false
                    showCustomize = true
                }
                .foregroundColor(.blue)
            }
            .padding()
        }
        .sheet(isPresented: $showCustomize){
            Form {
                Section( header: Text("Customize Restrictions")) {
                    TextField("Modify!", text: .constant(""))
                }
                
            }
        }
    }
}

#Preview {
    Customize()
}
