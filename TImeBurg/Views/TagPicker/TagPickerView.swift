//
//  TagPickerView.swift
//  TImeBurg
//
//  Created by Nebo on 17.03.2023.
//

import SwiftUI

struct TagPickerView: View {
    
    @ObservedObject var vm: TagPickerVM
    @Binding var currentTag: TagVM
    @Binding var isShow: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.white.opacity(isShow ? 0.1 : 0))
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        switch vm.statePickerView {
                            case .selected:
                                isShow = false
                            case .new:
                                vm.statePickerView = .selected
                        }
                    }
                }
            switch vm.statePickerView {
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
                    ForEach(vm.tagsVM) {
                        TTagView(vm: $0, fontSize: 16, circleWith: 8, opacity: 1, height: 20).tag($0)
                    }
                } label: {}
                .pickerStyle(.inline)
                .scaleEffect(x: 1.2, y: 1.2)
                .padding()
                
                Spacer()
                HStack {
                    TButton(action: {
                        withAnimation(.easeInOut) {
                            vm.statePickerView = .new
                        }
                    }, text: Text("New tag"))
                    
                    TButton(action: {
                        withAnimation(.easeInOut) {
                            isShow = false
                        }
                    }, text: Text("Save"))
                }
                .padding()
                .padding(.bottom, 10)
            }
        }
        .offset(x: isShow ? 0 : 400)
        .frame(height: UIScreen.main.bounds.height * 0.42)
        .frame(width:  UIScreen.main.bounds.width * 0.75)
    }
    
    @ViewBuilder
    private func newTagView() -> some View {
        GlassView {
            VStack {
                TTagView(vm: .init(name: vm.nameNewTag.isEmpty ? "Tag Name" : vm.nameNewTag, color: vm.colorNewTag), fontSize: 18, circleWith: 12, opacity: 1, height: 30)
                    .padding(.top, 30)
                    .padding(.horizontal)
                Spacer()
                HStack {
                    TTextField(placeholder: "Tag Name", text: $vm.nameNewTag)
                    Circle()
                        .fill(vm.colorNewTag)
                        .frame(width: 30)
                        .overlay(ColorPicker("Color Tag", selection: $vm.colorNewTag, supportsOpacity: false).opacity(0.015))
                }
                .padding()
                
                TButton(action: {
                    withAnimation(.easeInOut) {
                        if vm.saveTag() {
                            isShow = false
                        }
                    }
                }, text: Text("Save"))
                .padding()
            }
        }
        .offset(x: isShow ? 0 : 400)
        .frame(height: UIScreen.main.bounds.height * 0.3)
        .frame(width:  UIScreen.main.bounds.width * 0.75)
        .alert("Title cannot be empty", isPresented: $vm.showError) {
            Button(role: .cancel) { } label: {
                Text("Ok")
            }
        }
    }
    
}

struct TagPicker_Previews: PreviewProvider {
    static var previews: some View {
        THomeView(vm: THomeViewModel(serviceFactory: TServicesFactory()))
    }
}
