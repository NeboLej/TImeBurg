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
    @State private var isEdit = false
    
    init(vm: THouseVM) {
        self.vm = vm
        self.accumulated = vm.offset
    }
    
    var body: some View {
        ZStack {
            Image(vm.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: vm.width)
                .colorMultiply( vm.line == 0 ? .white : vm.line == 1 ? .gray : .black)
            if isEdit {
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
        }
        .offset(x: vm.offset.width, y: vm.offset.height)
        .gesture(DragGesture()
            .onChanged{ value in
                vm.offset = CGSize(width: value.translation.width + self.accumulated.width, height: vm.offset.height)
            }
            .onEnded{ value in
                self.accumulated = vm.offset })
        .gesture(TapGesture()
            .onEnded {
                isEdit.toggle()
                vm.onHouseClick()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    isEdit = false
                }
            })
    }
}

struct THouseView_Previews: PreviewProvider {
    static var previews: some View {
        THouseView(vm: THouseVM(house: THouse(image: "House1", timeExpenditure: 60, width: 50, line: 1, offsetX: 130)))
    }
}
