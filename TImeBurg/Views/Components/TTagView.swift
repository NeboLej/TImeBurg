//
//  TTag.swift
//  TImeBurg
//
//  Created by Nebo on 10.01.2023.
//

import SwiftUI

struct TTagView: View {
    
    @ObservedObject var vm: TagVM
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Circle()
                .fill(vm.color)
                .frame(width: 6)
                .padding(.horizontal, 3)
            Text(vm.name)
                .padding(.trailing, 6)
                .font(.custom(TFont.interRegular, size: 10))
                .foregroundColor(.outerSpace)
        }
        .frame(height: 16)
        .padding(3)
        .background(.white.opacity(0.67))
        .cornerRadius(20)
    }
}

struct TTagView_Previews: PreviewProvider {
    static var previews: some View {
        TTagView(vm: TagVM(name: "reading", color: .pink))
    }
}
