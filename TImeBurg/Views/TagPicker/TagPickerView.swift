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
    @State var isNew = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.white.opacity(isShow ? 0.2 : 0))
                .onTapGesture {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8, blendDuration: 0.1)) {
                        endEditing()
                        switch vm.statePickerView {
                            case .selected:
                                isShow = false
                            case .new:
                                vm.statePickerView = .selected
                                vm.nameNewTag = ""
                                isNew = false
                        }
                    }
                }
            ZStack {
                selectedTagView()
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
                    .frame(width:  UIScreen.main.bounds.width * 0.70)
                
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.8, blendDuration: 0.1)) {
                            vm.statePickerView = .new
                            isNew = true
                        }
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                    .font(.title)
                    .foregroundColor(.blueViolet)
                    
                    Button {
                        withAnimation(.easeInOut) {
                            vm.statePickerView = .selected
                            isShow = false
                            isNew = false
                        }
                    } label: {
                        Image(systemName: "checkmark.circle")
                    }
                    .font(.title)
                    .foregroundColor(.white)
                }
                .padding()
            }
        }
        .offset(x: isShow ? 0 : UIScreen.main.bounds.width)
        .offset(y: isNew ? -UIScreen.main.bounds.height : 0)
        .frame(height: UIScreen.main.bounds.height * 0.42)
        .frame(width:  UIScreen.main.bounds.width * 0.75)
    }
    
    @ViewBuilder
    private func newTagView() -> some View {
        GlassView {
            VStack {
                TTagView(vm: .init(name: vm.nameNewTag.isEmpty ? "Tag Name" : vm.nameNewTag, color: vm.colorNewTag), fontSize: 16, circleWith: 8, opacity: 1, height: 20)
                    .scaleEffect(x: 1.3, y: 1.3)
                    .padding(.top, 30)
                    .padding(.horizontal, 50)
                
                Spacer()
                HStack {
                    TTextField(placeholder: "Tag Name", text: $vm.nameNewTag)
                    Circle()
                        .fill(vm.colorNewTag)
                        .frame(width: 30)
                        .overlay(ColorPicker("Color Tag", selection: $vm.colorNewTag, supportsOpacity: false).opacity(0.015))
                }
                .padding()
                HStack{
                    Spacer()
                    Button {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.8, blendDuration: 0.1)) {
                            vm.statePickerView = .selected
                            vm.nameNewTag = ""
                            isNew = false
                            endEditing()
                        }
                    } label: {
                        Image(systemName: "xmark.circle")
                    }
                    .font(.title)
                    .foregroundColor(.blueViolet)
                    
                    Button {
                        withAnimation(.easeInOut) {
                            if vm.saveTag() {
                                vm.statePickerView = .selected
                                isShow = false
                                endEditing()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    isNew = false
                                }
                            }
                        }
                    } label: {
                        Image(systemName: "checkmark.circle")
                    }
                    .font(.title)
                    .foregroundColor(.white)
                }
                .padding()
            }
        }
        .offset(x: isShow ? 0 : 400)
        .offset(y: isNew ? 0 : 1000)
        .frame(height: UIScreen.main.bounds.height * 0.3)
        .frame(width:  UIScreen.main.bounds.width * 0.75)
        .alert("Title cannot be empty", isPresented: $vm.showError) {
            Button(role: .cancel) { } label: {
                Text("Ok")
            }
        }
//        .onTapGesture {
//            endEditing()
//        }
    }
}

struct TagPicker_Previews: PreviewProvider {
    static var previews: some View {
        THomeView(vm: THomeViewModel(serviceFactory: TServicesFactory()))
    }
}
