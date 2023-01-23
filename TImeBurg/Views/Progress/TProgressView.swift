//
//  TProgressView.swift
//  TImeBurg
//
//  Created by Nebo on 23.01.2023.
//

import SwiftUI

struct TProgressView: View {
    
    @ObservedObject var vm: TProgressVM
    
    var body: some View {
        VStack {
            switch vm.state {
                case .progress:
                    processView()
                case .completed:
                    completedView()
            }
            Spacer()
        }
        .background { LinearGradient(colors: [.blueViolet, .brightNavyBlue], startPoint: .top, endPoint: .bottom) }
        .ignoresSafeArea(.all)
        .animation(.easeOut, value: vm.state)
    }
    
    @ViewBuilder
    func processView() -> some View {
        VStack {
            HStack{
                Button { }
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
                .frame(width: 400, height: 250)
                .padding(.top, 30)
            TTimerView(vm: vm.getTimerVM())
            progressView()
            Text("do it now")
                .font(.custom(TFont.interRegular, size: 20))
                .foregroundColor(.white)
                .padding(.top, 40)
        }
    }
    
    @ViewBuilder
    func completedView() -> some View {
        VStack {
            ZStack(alignment: .bottom) {
                TLottieView(lottieFile: "Bubbles")
                    .frame(width: 300, height: 300)
                    
                Image(vm.getHome().image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120)
            }
            .padding(.top, 80)

            Rectangle()
                .fill(.white)
                .frame(height: 1)
                .padding(.horizontal, 30)
                .offset(y: -10)
            
            Text("Completed!")
                .font(.custom(TFont.interRegular, size: 27))
                .foregroundColor(.white)
                .padding(.vertical, 30)
            progressView()
            TButton(action: {
                
            }, text: Text("Разместить"))
            .frame(width: 180)
            .padding(.top, 50)
        }
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    func progressView() -> some View {
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
