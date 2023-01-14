//
//  ViewModifiers.swift
//  TImeBurg
//
//  Created by Nebo on 14.01.2023.
//

import SwiftUI

struct WhiteCapsule: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(TFont.interRegular, size: 12))
            .foregroundColor(.black)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color.white.opacity(0.67))
            .cornerRadius(20)
    }
}

//struct ViewModifiers_Previews: PreviewProvider {
//    static var previews: some View {
//        ViewModifiers()
//    }
//}
