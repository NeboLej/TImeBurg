//
//  TTextField.swift
//  TImeBurg
//
//  Created by Nebo on 17.03.2023.
//

import SwiftUI

struct TTextField: View {
    
    @State private var isFocus = false
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            
            TextField("", text: $text) { (status) in
                if text.isEmpty {
                    withAnimation( status ? .easeIn : .easeOut) {
                        isFocus = status
                    }
                }
            } onCommit: {
                if text == "" {
                    withAnimation(.easeOut) {
                        isFocus = false
                    }
                }
            }
            .padding(.top, isFocus ? 15 : 0)
            .font(.custom(TFont.interRegular, size: 18))
            .foregroundColor(.black)
            .background(
                Text(placeholder)
                    .scaleEffect(isFocus ? 0.8 : 1)
                    .offset(x: isFocus ? -7 : 0, y: isFocus ? -15 : 0)
                    .foregroundColor(.outerSpace)
                    .font(.custom(TFont.interRegular, size: 18))
                , alignment: .leading)
            
            .padding(.horizontal)
            
            Rectangle()
                .fill(isFocus ? Color.bananaYellow : Color.white)
                .opacity(isFocus ? 1 : 0.95)
                .frame(height: 1)
                .offset(x: 0, y: -8)
                .padding(.horizontal, isFocus ? 8 : 10)
        }.onAppear {
            if !text.isEmpty {
                isFocus = true
            }
        }
    }
}


struct TTextField_Previews: PreviewProvider {
    static var previews: some View {
        TTextField(placeholder: "asd", text: .init(get: {
            "asddsds"
        }, set: { _ in
            
        }))
    }
}
