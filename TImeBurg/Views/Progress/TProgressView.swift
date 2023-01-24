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
                TLottieView(lottieFile: "OrangeHome")
                    .frame(width: proxy.size.width * 0.7, height: proxy.size.width * 0.7 * 9 / 12)
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
            Button(role: .destructive) {  dismiss() } label: {
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
                ZStack(alignment: .bottom) {
                    TLottieView(lottieFile: "Bubbles")
                        .frame(width: proxy.size.width * 0.7, height: proxy.size.width * 0.7)
                        
                    Image(vm.getHome().image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120)
                }
                .padding(.top, 60)

                Rectangle()
                    .fill(.white)
                    .frame(height: 1)
                    .padding(.horizontal, 30)
                    .offset(y: -10)
                
                Text("Completed!")
                    .font(.custom(TFont.interRegular, size: 27))
                    .foregroundColor(.white)
                    .padding(.vertical, 20)
                progressCircleView()
                TButton(action: {
                    
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
        TProgressView(vm: .init(minutes: 1))
    }
}
