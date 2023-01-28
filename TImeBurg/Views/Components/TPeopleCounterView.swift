//
//  TPeopleCounterView.swift
//  TImeBurg
//
//  Created by Nebo on 13.01.2023.
//

import SwiftUI

struct TPeopleCounterView: View {
    
    @Binding var count: Int
    
    var body: some View {
        HStack {
            Image(systemName: "person")
                .foregroundColor(.black)
            Spacer()
            Text("\(count)")
                .font(.custom(TFont.interRegular, size: 14))
                .foregroundColor(.black)
        }
        .modifier(WhiteCapsule())
    }
}

struct TPeopleCounterView_Previews: PreviewProvider {
    static var previews: some View {
        TPeopleCounterView(count: .init(get: {
            123
        }, set: { _ in
            
        }))
    }
}
