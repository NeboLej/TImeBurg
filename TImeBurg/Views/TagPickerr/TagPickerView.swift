//
//  TagPickerView.swift
//  TImeBurg
//
//  Created by Nebo on 17.03.2023.
//

import SwiftUI

struct TagPickerView: View {
    
    @Binding var tagPickerShow: Bool
    @Binding var currentTag: TagVM
    @Binding var tagsVM: [TagVM]
    
    private enum StateTagView{
        case selected, new
    }
    
    @State private var statePickerView: StateTagView = .new
    @State private var nameNewTag: String = ""
    @State private var colorNewTag: Color = .blueViolet
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.white.opacity(tagPickerShow ? 0.1 : 0))
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        emptyClick()
                    }
                }
            switch statePickerView {
                case .selected:
                    selectedTagView()
                case .new:
                    newTagView()
            }
        }
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    private func selectedTagView() -> some View {
        GlassView {
            VStack {
                Picker(selection: $currentTag) {
                    ForEach(tagsVM) {
                        TTagView(vm: $0, fontSize: 16, circleWith: 8, opacity: 1, height: 20).tag($0)
                    }
                } label: {}
                .pickerStyle(.inline)
                .scaleEffect(x: 1.2, y: 1.2)
                .padding()
                
                Spacer()
                HStack {
                    TButton(action: {
                        statePickerView = .new
                    }, text: Text("New tag"))
                    
                    TButton(action: {
                        tagPickerShow = false
                    }, text: Text("Save"))
                }
                .padding()
                .padding(.bottom, 10)
            }
        }
        .offset(x: tagPickerShow ? 0 : 400)
        .frame(height: UIScreen.main.bounds.height * 0.42)
        .frame(width:  UIScreen.main.bounds.width * 0.75)
    }
    
    @ViewBuilder
    private func newTagView() -> some View {
        GlassView {
            VStack {
                
                TTagView(vm: .init(name: nameNewTag.isEmpty ? "Tag Name" : nameNewTag, color: colorNewTag), fontSize: 18, circleWith: 12, opacity: 1, height: 30)
                    .padding(.top, 30)
                Spacer()
                HStack {
                    TTextField(placeholder: "Tag Name", text: $nameNewTag)
                    Circle()
                        .fill(colorNewTag)
                        .frame(width: 30)
                        .overlay(ColorPicker("Color Tag", selection: $colorNewTag, supportsOpacity: false).opacity(0.015))
                }
                .padding()
                
                TButton(action: {
                    tagPickerShow = false
                }, text: Text("Save"))
                .padding()
            }
        }
        .offset(x: tagPickerShow ? 0 : 400)
        .frame(height: UIScreen.main.bounds.height * 0.3)
        .frame(width:  UIScreen.main.bounds.width * 0.75)
    }
    
    private func emptyClick() {
        switch statePickerView {
            case .selected:
                tagPickerShow = false
            case .new:
                statePickerView = .selected
        }
    }
}

struct TagPicker_Previews: PreviewProvider {
    static var previews: some View {
        THomeView(vm: THomeViewModel(serviceFactory: TServicesFactory()))
    }
}
