//
//  TTag.swift
//  TImeBurg
//
//  Created by Nebo on 10.01.2023.
//

import SwiftUI

struct TTagView: View {
    
    @ObservedObject var vm: TagVM
    var fontSize: CGFloat = 10
    var circleWith: CGFloat = 6
    var opacity: CGFloat = 0.67
    var height: CGFloat = 16
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Circle()
                .fill(vm.color)
                .frame(width: circleWith)
                .padding(.horizontal, 3)
            Text(vm.name)
                .padding(.trailing, 6)
                .font(.custom(TFont.interRegular, size: fontSize))
                .foregroundColor(.outerSpace)
        }
        .frame(height: height)
        .padding(3)
        .background(.white.opacity(opacity))
        .cornerRadius(20)
    }
}

struct TTagView_Previews: PreviewProvider {
    static var previews: some View {
        TTagView(vm: TagVM(name: "reading", color: .pink))
    }
}
