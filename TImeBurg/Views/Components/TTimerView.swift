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
        TTimerView(vm: TTimerVM(minutes: 4))
    }
}


protocol TTimerListenerProtocol {
    func timeRuns(seconds: Float)
    func timeFinish(on: Bool)
}

class TTimerVM: ObservableObject {
    @Published var isActive: Bool = true
    @Published var time: String = ""
    @Published var minutes: Float = 1 {
        didSet {
            self.time = "\(Int(minutes)):00"
        }
    }
    
    private var initialTime = 0
    private var endDate = Date()
    private let parent: Any?
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init(minutes: Float, parent: Any? = nil) {
        self.minutes = minutes
        self.parent = parent
        endDate = Calendar.current.date(byAdding: .minute, value: Int(minutes), to: endDate)!
    }
    

    
//    func start() {
//        initialTime = Int(minutes)
//        endDate = Date()
////        isActive = true
//        endDate = Calendar.current.date(byAdding: .minute, value: Int(minutes), to: endDate)!
//    }
    
//    func reset() {
//        minutes = Float(initialTime)
////        isActive = false
//        time = "\(Int(minutes)):00"
//    }
    
    func updateCountdown() {
        guard isActive else { return }
        
        let now = Date()
        let diff = endDate.timeIntervalSince1970 - now.timeIntervalSince1970
        
        if diff <= 0 {
            (parent as? TTimerListenerProtocol)?.timeFinish(on: true)
            time = "0:00"
            return
        }
        
        let date = Date(timeIntervalSince1970: diff)
        let min = Calendar.current.component(.minute, from: date)
        let sec = Calendar.current.component(.second, from: date)
        
//        self.sec = Float(sec)
        minutes = Float(min)
        time = String(format: "%d:%02d", min, sec)
        (parent as? TTimerListenerProtocol)?.timeRuns(seconds: Float(min * 60 + sec))
    }
}
