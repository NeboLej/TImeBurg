//
//  TButtons.swift
//  TImeBurg
//
//  Created by Nebo on 10.01.2023.
//

import SwiftUI

struct TButton: View {
    
    let action: () -> Void
    let text: Text
    
    var body: some View {
        Button {
            action()
        } label: {
            text
                .foregroundColor(.black)
        }
//        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .background(Color.white)
        .cornerRadius(30)
    }
}

struct TButtons_Previews: PreviewProvider {
    static var previews: some View {
        TButton(action: {
            
        }, text: Text("asasd"))
    }
}
