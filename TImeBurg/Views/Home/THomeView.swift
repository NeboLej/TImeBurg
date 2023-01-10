//
//  THomeView.swift
//  TImeBurg
//
//  Created by Nebo on 09.01.2023.
//

import SwiftUI
import UIKit

struct THomeView: View {
    
    @ObservedObject var viewModel: THomeViewModel
    @State var segmentIndex = 0
    
    
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
            Rectangle()
                .fill(Color.black.opacity(0.8))
                .frame(height: 100)
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

                    Text("40")
                        .font(.custom(TFont.interRegular, size: 60))
                        .foregroundColor(.white)
                    Text("min")
                        .font(.custom(TFont.interRegular, size: 40))
                        .foregroundColor(.white)
                        .padding(.top, -15)
                    
                    TButton(action: {}, text: Text("Start") )
                        .frame(maxWidth: .infinity)
                }
//                .background(.red)
                .padding(.leading, 15)
                .frame(width: 150)
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    Picker(selection: $segmentIndex) {
                        Text("строить").tag(0)
                            .font(.custom(TFont.interRegular, size: 5))
                        Text("озеленение").tag(1)
                            .font(.custom(TFont.interRegular, size: 5))
                        Text("комфорт").tag(2)
                            .font(.custom(TFont.interRegular, size: 30))
    
                    } label: { }
                        .pickerStyle(.segmented)
//                    .padding(.horizontal, 20)
//                    .cornerRadius(10)
                    .padding(.top, 10)
                    .onAppear {
                        UISegmentedControl.appearance().backgroundColor = .white
                        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(.newYorkPink)
                        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black, .font: UIFont(name: TFont.interRegular, size: 10)!], for: .normal)
                        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
                    }
                    
                    TTagView(vm: TTagVM(name: "reading", color: .pink))
                }
                Spacer()
            }
//            .background(.green)
            .padding(.top, 17)
        }
        .background {
            LinearGradient(colors: [.blueViolet, .brightNavyBlue.opacity(0.53)], startPoint: .top, endPoint: .bottom)
        }
        .cornerRadius(25)
        .padding(.horizontal, 5)
    }
}

struct THomeView_Previews: PreviewProvider {
    static var previews: some View {
        THomeView(viewModel: THomeViewModel())
    }
}
