//
//  THomeView.swift
//  TImeBurg
//
//  Created by Nebo on 09.01.2023.
//

import SwiftUI

struct THomeView: View {
    
    @ObservedObject var vm: THomeViewModel
    @State private var offsetX = 0.0
    let width: CGFloat
    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                city(vm: vm.currentCityVM)
                    .gesture(TapGesture().onEnded {
                        withAnimation(.easeInOut) {
                            vm.onClickCity()
                        }
                    })
                    .onReceive(vm.$snapshotCity, perform: { newValue in
                        if newValue {
                            let image = TCityView(vm: vm.currentCityVM)
                                .frame(height: 280, alignment: .top).snapshot()
                                vm.saveImage(image: image)
                        }
                    })
                    .overlay(alignment: .trailing) {
                        cityMenu()
                    }
                newHouseView()
                    .padding(.top, -30)
                    .padding(.horizontal, 5)
                TCityStatisticView(vm: vm.currentCityVM)
                    .padding(.horizontal, 5)
            }
            .coordinateSpace(name: "SCROLL")
            .ignoresSafeArea(.all, edges: .top)
            .background(.white)
            .fullScreenCover(isPresented: $vm.isProgress) {
                vm.isProgress = false
                vm.afterSnapshot()
            } content: {
                TProgressView(vm: vm.getProgressVM())
            }
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
        .frame(height: width * 0.9)
    }
    
    @ViewBuilder
    private func cityMenu() -> some View {
        VStack(alignment: .center, spacing: 25) {
            if vm.cityCanEdit {
                Button(action: { withAnimation { vm.saveCity() }  }, label: {
                    Image(systemName: "checkmark.circle")
                        .foregroundColor(.black)
                } )
                Button(action: { withAnimation { vm.dontSaveCity() }  }, label: {
                    Image(systemName: "xmark.circle")
                        .foregroundColor(.black)
                } )
            } else {
                Button(action: { withAnimation { vm.editCity() }  }, label: {
                    Image(systemName: "paintbrush")
                        .foregroundColor(.black)
                } )
                Button(action: {}, label: {
                    Image(systemName: "info.circle")
                        .foregroundColor(.black)
                } )
                Button(action: {}, label: {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.black)
                } )
            }
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 12)
        .background(Color.white.opacity(0.67))
        .cornerRadius(20, corners: [.bottomLeft, .topLeft])
        .offset(x: vm.isShowMenu ? 0 : 50, y: -20)
    }
    
    @ViewBuilder
    private func newHouseView() -> some View {
        VStack(alignment: .center, spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                Text(vm.selectedHouse == nil ? "New House": "House upgrade")
                    .font(.custom(TFont.interRegular, size: 20))
                    .foregroundColor(.white)
                    .padding(.top, 3)

                Spacer()
                
                VStack(alignment: .trailing, spacing: 0) {
                    activityPicker()
                        .opacity(vm.selectedHouse == nil ? 1 : 0)
                        .padding(.leading, 10)
                    TPeopleCounterView(count: $vm.countPeople)
                        .frame(width: 80)
                        .opacity(vm.selectedHouse == nil ? 0 : 1)
                }
                .offset(y: vm.selectedHouse == nil ?  0 : -33)
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)

 
            HStack(alignment: .top, spacing: 0) {
                VStack(alignment: .center, spacing: 0) {
                    Text("\(Int(vm.timeActivity))")
                        .font(.custom(TFont.interRegular, size: 60))
                        .foregroundColor(.white)
                        .padding(.top, 10)
                    Text("min")
                        .font(.custom(TFont.interRegular, size: 40))
                        .foregroundColor(.white)
                        .padding(.top, -15)
                    Spacer()
                    TButton(action: { vm.startActivity() }, text: Text("Start") )
                        .frame(maxWidth: .infinity)
                }
                .frame(width: 150)
                .padding(.leading, 20)
                
                Spacer()
                


                VStack(alignment: .center, spacing: 10) {
                    Image(vm.selectedHouse == nil ? vm.imageSet[vm.activityType.rawValue] : vm.selectedHouse!.image)
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal)
                        .offset(x: offsetX)
                        .frame(height: 150)
                        .animation(Animation.easeOut, value: offsetX)
                    
                    Button {
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) {
                            vm.tagPickerShow = true
                        }
                    } label: {
                        HStack(spacing: 3) {
                            TTagView(vm: vm.currentTag)
                            Image(systemName: "arrow.clockwise.circle")
                                .foregroundColor(.white)
                        }
                    }
                    .offset(x: 8)
                }
                .padding(.trailing, vm.selectedHouse == nil ? 20 : 40)
            }

            timeSlider()
                .padding(.horizontal, 20)
                .padding(.top, 12)
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
            Text("build").tag(0)
            Text("greening").tag(1)
            Text("cleaning").tag(2)
            
        } label: { }
            .pickerStyle(.segmented)
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
            Slider(value: $vm.timeActivity, in: 1...120, step: 1)
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
        THomeView(vm: THomeViewModel(serviceFactory: TServicesFactory()), width: UIScreen.main.bounds.width)
    }
}
