//
//  THomeView.swift
//  TImeBurg
//
//  Created by Nebo on 09.01.2023.
//

import SwiftUI
import UIKit

struct THomeView: View {
    
    @ObservedObject var vm: THomeViewModel
    @State private var offsetX = 0.0
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            cityView()
            newHouseView()
                .padding(.top, -30)
        }
        .ignoresSafeArea(.all, edges: .top)
    }
    
    
    @ViewBuilder
    private func cityView() -> some View {
        VStack(alignment: .center, spacing: 0) {
            Rectangle()
                .fill(LinearGradient(colors: [.pink.opacity(0.8), .blueViolet, .brightNavyBlue], startPoint: .bottom, endPoint: .top))
                .frame(height: 300)
            Rectangle()
                .fill(Color.gray)
                .frame(height: 20)
            Rectangle()
                .fill(Color.black.opacity(0.85))
                .frame(height: 6)
            ZStack(alignment: .center) {
                Rectangle()
                    .fill(Color.black.opacity(0.8))
                    .frame(height: 100)
                HStack(alignment: .center, spacing: 30) {
                    Rectangle()
                        .fill(Color.white.opacity(0.8))
                        .frame(width: 50, height: 3)
                    Rectangle()
                        .fill(Color.white.opacity(0.8))
                        .frame(width: 50, height: 3)
                    Rectangle()
                        .fill(Color.white.opacity(0.8))
                        .frame(width: 50, height: 3)
                    Rectangle()
                        .fill(Color.white.opacity(0.8))
                        .frame(width: 50, height: 3)
                    Rectangle()
                        .fill(Color.white.opacity(0.8))
                        .frame(width: 50, height: 3)
                }

            }
            
        }

    }
    
    @ViewBuilder
    private func newHouseView() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("New House")
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
                    TButton(action: { vm.StartActivity() }, text: Text("Start") )
                        .frame(maxWidth: .infinity)
                }
                .padding(.leading, 15)
                .frame(width: 150)
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    activityPicker()
                    
                    HStack(alignment: .top, spacing: 0) {
                        VStack(alignment: .leading, spacing: 16) {
                            TTagView(vm: TTagVM(name: "reading", color: .pink))
                                .padding(.top, 23)
                            CheckBoxView(checked: $vm.isSetting1,
                                         text: Text("Некий выбор")
                                .font(.custom(TFont.interRegular, size: 10))
                                .foregroundColor(.white)
                            )
                            CheckBoxView(checked: $vm.isSetting2,
                                         text: Text("Некий выбор2")
                                .font(.custom(TFont.interRegular, size: 10))
                                .foregroundColor(.white)
                            )
                        }
                        Image(vm.imageSet[vm.activityType.rawValue])
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
        .padding(.horizontal, 5)
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

struct CheckBoxView: View {
    @Binding var checked: Bool
    let text: Text

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Image(systemName: checked ? "dot.square" : "square")
                .foregroundColor(checked ? Color(UIColor.white) : Color.white)
                .onTapGesture {
                    self.checked.toggle()
                }
            text
        }

    }
}
