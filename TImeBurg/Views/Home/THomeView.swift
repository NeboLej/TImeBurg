//
//  THomeView.swift
//  TImeBurg
//
//  Created by Nebo on 09.01.2023.
//

import SwiftUI
//import UIKit

struct THomeView: View {
    
    @ObservedObject var vm: THomeViewModel
    @State private var offsetX = 0.0
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            city(vm: vm.getCurrentCity())
                .gesture(TapGesture()
                    .onEnded { vm.emptyClick() })
            newHouseView()
                .padding(.top, -30)
                .padding(.horizontal, 5)
            TCityStatisticView(vm: vm.getCurrentCity())
                .padding(.horizontal, 5)
        }
        .coordinateSpace(name: "SCROLL")
        .ignoresSafeArea(.all, edges: .top)
        .background(.white)
        .fullScreenCover(isPresented: $vm.isProgress) {
            vm.isProgress = false
        } content: {
            TProgressView(vm: vm.startActivity())
        }
    }
    
    @ViewBuilder
    private func city(vm: TCityVM) -> some View {
        GeometryReader { proxy in
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let size = proxy.size
            let height = size.height + minY
            
            TCityView(vm: vm)
                .frame(width: size.width, height: height, alignment: .top)
                .offset(y: minY > 0 ? -minY : 0)
        }
        .frame(height: 350)
    }
    
    @ViewBuilder
    private func newHouseView() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(vm.selectedHouse == nil ? "New House": "House upgrade")
                .font(.custom(TFont.interRegular, size: 20))
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.top, 20)
            
            
            HStack(alignment: .top, spacing: 0) {
                
                VStack(alignment: .center, spacing: 0) {
                    
                    Text("\(Int(vm.timeActivity))")
                        .font(.custom(TFont.interRegular, size: 60))
                        .foregroundColor(.white)
                        .padding(.top, 16)
                    Text("min")
                        .font(.custom(TFont.interRegular, size: 40))
                        .foregroundColor(.white)
                        .padding(.top, -15)
                    Spacer()
                    TButton(action: { vm.isProgress = true }, text: Text("Start") )
                        .frame(maxWidth: .infinity)
                }
                .padding(.leading, 15)
                .frame(width: 150)
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    activityPicker()
                        .opacity(vm.selectedHouse == nil ? 1 : 0)
                    TPeopleCounterView(count: vm.selectedHouse?.timeExpenditure ?? 0)
                        .frame(width: 80)
                        .opacity(vm.selectedHouse == nil ? 0 : 1)
                    
                    HStack(alignment: .top, spacing: 0) {
                        VStack(alignment: .leading, spacing: 16) {
                            TTagView(vm: TTagVM(name: "reading", color: .pink))
                                .padding(.top, 23)
                            TCheckBoxView(checked: $vm.isSetting1,
                                         text: Text("Некий выбор")
                                .font(.custom(TFont.interRegular, size: 10))
                                .foregroundColor(.white)
                            )
                            TCheckBoxView(checked: $vm.isSetting2,
                                         text: Text("Некий выбор2")
                                .font(.custom(TFont.interRegular, size: 10))
                                .foregroundColor(.white)
                            )
                        }
                        Image(vm.selectedHouse == nil ? vm.imageSet[vm.activityType.rawValue] : vm.selectedHouse!.image)
                            .resizable()
                            .scaledToFit()
                            .padding(.horizontal)
                            .offset(x: offsetX)
                            .frame(height: 150)
                            .animation(Animation.easeOut, value: offsetX)
                    }
                }
                Spacer()
            }
            .padding(.top, 17)
            
            timeSlider()
                .padding(.horizontal, 30)
                .padding(.top, 16)
                .padding(.bottom, 30)
        }
        .background {
            LinearGradient(colors: [.blueViolet, .brightNavyBlue.opacity(0.53)], startPoint: .top, endPoint: .bottom)
        }
        .cornerRadius(25)
    }
    
    @ViewBuilder
    private func activityPicker() -> some View {
        Picker(selection: Binding(get: {
            vm.activityType.rawValue
        }, set: { newValue in
            move(offset: 500)
            vm.activityType = TActivityType(rawValue: newValue)!
            
        })) {
            Text("строить").tag(0)
            Text("озеленение").tag(1)
            Text("комфорт").tag(2)
            
        } label: { }
            .pickerStyle(.segmented)
            .padding(.top, 10)
            .onAppear {
                UISegmentedControl.appearance().backgroundColor = .white
                UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(.newYorkPink)
                UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black, .font: UIFont(name: TFont.interRegular, size: 10)!], for: .normal)
                UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
            }
    }
    
    @ViewBuilder
    private func timeSlider() -> some View {
        VStack(alignment: .center, spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                Text("10 min")
                    .font(.custom(TFont.interRegular, size: 12))
                    .foregroundColor(.white)
                Spacer()
                Text("120 min")
                    .font(.custom(TFont.interRegular, size: 12))
                    .foregroundColor(.white)
            }
            Slider(value: $vm.timeActivity, in: 10...120, step: 5)
                .tint(.white)
        }
    }
    
    private func move(offset: Double) {
        offsetX = offset
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.offsetX = 0
        }
    }
}

struct THomeView_Previews: PreviewProvider {
    static var previews: some View {
        THomeView(vm: THomeViewModel())
    }
}
