//
//  THouseView.swift
//  TImeBurg
//
//  Created by Nebo on 18.01.2023.
//

import SwiftUI

struct THouseView: View {
    
    @ObservedObject var vm: THouseVM
    
    @State private var accumulated: CGSize
    @State var isEdit: Bool = false
    @Binding var isCanEdit: Bool
    
    init(vm: THouseVM, isCanEdit: Binding<Bool>) {
        self.vm = vm
        self._isCanEdit = isCanEdit
        self.accumulated = vm.offset
    }
    
    var body: some View {
        ZStack {
            Image(vm.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: vm.width)
                .colorMultiply( vm.line == 0 ? .white : vm.line == 1 ? .gray : .black)
                .overlay {
                    if isEdit && isCanEdit {
                        changeLineView()
                    } else if isEdit && !isCanEdit {
                        pickView()
                    }
                }
        }
        .offset(x: vm.offset.width, y: vm.offset.height)
        .gesture(DragGesture()
            .onChanged{ value in
                if isCanEdit {
                    vm.move(offsetX: value.translation.width + self.accumulated.width)
                }
            }
            .onEnded{ value in
                self.accumulated = vm.offset })
        .gesture(TapGesture()
            .onEnded {
                withAnimation {
                    isEdit.toggle()
                    vm.onHouseClick()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        isEdit = false
                    }
                }
            })
    }
    
    @ViewBuilder
    func changeLineView() -> some View {
        VStack {
            if vm.line == 0 || vm.line == 1 {
                Button {
                    vm.changedLine(st: 1)
                } label: {
                    Image(systemName: "chevron.up")
                }
                .modifier(WhiteCapsule())
            }

            if vm.line == 1 || vm.line == 2 {
                Button {
                    vm.changedLine(st: -1)
                } label: {
                    Image(systemName: "chevron.down")
                }
                .modifier(WhiteCapsule())
            }
        }
        .offset(x: -20)
    }
    
    @ViewBuilder
    func pickView() -> some View {
        Rectangle()
            .stroke(
                Color.white.opacity(0.4),
                 style: StrokeStyle(
                     lineWidth: 2
                 ))
            .frame(width: vm.width + 10)
    }
}

struct THouseView_Previews: PreviewProvider, THouseListenerProtocol {
    static var previews: some View {
        THouseView(vm: THouseVM(house: THouse(image: "House1", timeExpenditure: 60, width: 50, line: 1, offsetX: 130)), isCanEdit: .init(get: {
            false
        }, set: { _ in
            
        }))
    }
    
    func onHouseClick(id: String) {
        
    }
}
