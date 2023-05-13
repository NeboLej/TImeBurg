//
//  TTimerView.swift
//  TImeBurg
//
//  Created by Nebo on 22.01.2023.
//

import SwiftUI

struct TTimerView: View {
    
    @ObservedObject var vm: TTimerVM
    
    
    var body: some View {
        Text(vm.time)
            .font(.custom(TFont.interRegular, size: 60))
            .foregroundColor(.white)
//        VStack {

           
            
//            Slider(value: $vm.minutes, in: 1...10, step: 1)
//                .padding()
//                .disabled(vm.isActive)
//                .animation(.easeOut, value: vm.minutes)
//
//            HStack {
//                Button {
//                    vm.start()
//                } label: {
//                    Text("Start")
//                }
//                .disabled(vm.isActive)
//
//                Button {
//                    vm.reset()
//                } label: {
//                    Text("Reset")
//                        .foregroundColor(.red)
//                }
//
//            }
//
//        }
        .onReceive(vm.timer) { _ in
            vm.updateCountdown()
        }
        
    }
}

struct TTimer_Previews: PreviewProvider {
    static var previews: some View {
        TTimerView(vm: TTimerVM(minutes: 4, startSecond: 0))
    }
}
