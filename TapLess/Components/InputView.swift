//
//  inputView.swift
//  TapLess
//
//  Created by Liam Sebestyen on 2025-02-24.
//

import SwiftUI

struct inputView: View {
    @Binding var text : String
    let title: String
    let placeholder: String
    var isSecureField: Bool = false
    var body: some View {
        VStack{
            Text(title)
                .foregroundColor(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)
            
            if isSecureField {
                //Password field
                
                SecureField(placeholder, text: $text)
                    .font(.system(size:14))
            
            } else {
                TextField(placeholder, text: $text)
                    .font(.system(size:14))
                
            }
            Divider()
        }
        
    }
}

#Preview {
            inputView(text: .constant(""), title: "Liam", placeholder: "liamsebestyen@uvic.ca")
}
