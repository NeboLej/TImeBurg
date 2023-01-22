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
        VStack {
            Text(vm.time)
                .font(.custom(TFont.interRegular, size: 70))
            
            Slider(value: $vm.minutes, in: 1...10, step: 1)
                .disabled(vm.isActive)
                .animation(.easeOut, value: vm.minutes)
            
            HStack {
                Button {
                    vm.start()
                } label: {
                    Text("Start")
                }
                .disabled(vm.isActive)

                Button {
                    vm.reset()
                } label: {
                    Text("Reset")
                        .foregroundColor(.red)
                }
                
            }
            
                
        }
        .onReceive(vm.timer) { _ in
            vm.updateCountdown()
        }
    }
}

struct TTimer_Previews: PreviewProvider {
    static var previews: some View {
        TTimerView(vm: TTimerVM())
    }
}


class TTimerVM: ObservableObject {
    @Published var isActive: Bool = false
    @Published var time: String = "5:00"
    @Published var minutes: Float = 5.00 {
        didSet {
            self.time = "\(Int(minutes)):00"
        }
    }
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private var initialTime = 0
    private var endDate = Date()
    
    func start() {
        initialTime = Int(minutes)
        endDate = Date()
        isActive = true
        endDate = Calendar.current.date(byAdding: .minute, value: Int(minutes), to: endDate)!
    }
    
    func reset() {
        minutes = Float(initialTime)
        isActive = false
        time = "\(Int(minutes)):00"
    }
    
    func updateCountdown() {
        guard isActive else { return }
        
        let now = Date()
        let diff = endDate.timeIntervalSince1970 - now.timeIntervalSince1970
        
        if diff <= 0 {
            isActive = false
            time = "0:00"
            return
        }
        
        let date = Date(timeIntervalSince1970: diff)
        let min = Calendar.current.component(.minute, from: date)
        let sec = Calendar.current.component(.second, from: date)
        
        minutes = Float(min)
        time = String(format: "%d:%02d", min, sec)
    }
}
