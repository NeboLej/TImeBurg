//
//  TPeopleCounterView.swift
//  TImeBurg
//
//  Created by Nebo on 13.01.2023.
//

import SwiftUI

struct TPeopleCounterView: View {
    
    @State var count: Int
    
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
//        .padding(.vertical, 6)
//        .padding(.horizontal, 12)
//        .background(Color.white.opacity(0.67))
//        .cornerRadius(20)
    }
}

struct TPeopleCounterView_Previews: PreviewProvider {
    static var previews: some View {
        TPeopleCounterView(count: 124334)
    }
}
