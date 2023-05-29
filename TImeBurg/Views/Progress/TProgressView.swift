//
//  TProgressView.swift
//  TImeBurg
//
//  Created by Nebo on 23.01.2023.
//

import SwiftUI

struct TProgressView: View {
    
    @ObservedObject var vm: TProgressVM
    @Environment(\.dismiss) var dismiss
    @State var isShowAlert = false
    
    var body: some View {
        VStack {
            switch vm.state {
                case .progress:
                    processView()
                case .completed:
                    completedView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background { LinearGradient(colors: [.blueViolet, .brightNavyBlue], startPoint: .top, endPoint: .bottom) }
        .ignoresSafeArea(.all)
        .animation(.easeIn, value: vm.state)
    }
    
    @ViewBuilder
    func processView() -> some View {
        GeometryReader { proxy in
            VStack {
                HStack{
                    Button { isShowAlert = true }
                label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 20, height: 20)
                }
                    Spacer()
                }
                .padding(.top, 50)
                .padding(.leading, 30)
                let width = proxy.size.width > 550 ? 550 : proxy.size.width
                TLottieView(lottieFile: "OrangeHome")
                    .frame(width: width * 0.7, height: width * 0.7 * 9 / 12)
                    .padding(.top, 10)
                TTimerView(vm: vm.getTimerVM())
                progressCircleView()
                Text("do it now")
                    .font(.custom(TFont.interRegular, size: 20))
                    .foregroundColor(.white)
                    .padding(.top, 20)
            }
        }
        .alert("При закрытии этого экрана таймер будет остановлен", isPresented: $isShowAlert) {
            Button(role: .destructive) {
                dismiss()
                vm.close()
            } label: {
                Text("Закрыть")
            }
            Button(role: .cancel) { } label: {
                Text("Остаться")
            }
        }
    }
    
    @ViewBuilder
    func completedView() -> some View {
        GeometryReader { proxy in
            VStack {
                let width = proxy.size.width > 550 ? 550 : proxy.size.width
                ZStack(alignment: .bottom) {
                    TLottieView(lottieFile: "Bubbles")
                        .frame(width: width * 0.7, height: width * 0.7)
                        .offset(y: 20)
                        .padding(.top, proxy.size.width > 550 ? -70 : 0)
                        
                    Image(vm.getHome().image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120)
                }
                .padding(.top, 60)

                Rectangle()
                    .fill(.white)
                    .frame(height: 1)
                    .padding(.horizontal, width * 0.2)
                    .offset(y: -10)
                
                Text("Completed!")
                    .font(.custom(TFont.interRegular, size: 27))
                    .foregroundColor(.white)
                    .padding(.vertical, 20)
                progressCircleView()
                TButton(action: {
                    vm.saveHouse()
                    dismiss()
                }, text: Text("Разместить")
                    .font(.custom(TFont.interRegular, size: 16))
                    .foregroundColor(.black))
                .frame(width: 180)
                .padding(.top, 40)
            }
        }
    }
    
    @ViewBuilder
    func progressCircleView() -> some View {
        TCircleProgressView(progress: vm.progress)
            .overlay(alignment: .bottom) {
                if vm.state == .completed {
                    VStack(alignment: .center, spacing: 0) {
                        Text("\(Int(vm.minutes))")
                        Text("min")
                    }
                    .offset(y: -10)
                    .foregroundColor(.white)
                }
            }
    }
}

struct TProgressView_Previews: PreviewProvider {
    static var previews: some View {
        TProgressView(vm: TProgressVM(minutes: 1, tag: .init(name: "djn", color: "123452"), upgradedHouse: nil, startSecond: 0, serviceFactory: TServicesFactory()))
    }
}
