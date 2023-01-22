//
//  TCheckBoxView.swift
//  TImeBurg
//
//  Created by Nebo on 22.01.2023.
//

import SwiftUI

struct TCheckBoxView: View {
    @Binding var checked: Bool
    let text: Text
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Image(systemName: checked ? "dot.square" : "square")
                .foregroundColor(checked ? .white : .white)
                .onTapGesture {
                    self.checked.toggle()
                }
            text
        }
        
    }
}


struct TCheckBoxView_Previews: PreviewProvider {
    static var previews: some View {
        TCheckBoxView(checked: .init(get: { false}, set: { _  in }), text: Text("ntndf"))
    }
}
