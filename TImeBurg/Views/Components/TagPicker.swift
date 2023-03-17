//
//  TagPicker.swift
//  TImeBurg
//
//  Created by Nebo on 17.03.2023.
//

import SwiftUI

struct TagPicker: View {
    
    @Binding var tagPickerShow: Bool
    @Binding var currentTag: TagVM
    @Binding var tagsVM: [TagVM]
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.white.opacity(tagPickerShow ? 0.1 : 0))
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        tagPickerShow = false
                    }
                }
            GlassView {
                Picker(selection: $currentTag) {
                    ForEach(tagsVM) {
                        TTagView(vm: $0, fontSize: 16, circleWith: 8, opacity: 1, height: 20).tag($0)
                    }
                } label: {}
                .pickerStyle(.inline)
            }
            .offset(x: tagPickerShow ? 0 : 400)
            .frame(height: UIScreen.main.bounds.height * 0.45)
            .frame(width:  UIScreen.main.bounds.width * 0.75)
        }
        .ignoresSafeArea()
    }
}

struct TagPicker_Previews: PreviewProvider {
    static var previews: some View {
        THomeView(vm: THomeViewModel(serviceFactory: TServicesFactory()))
    }
}
