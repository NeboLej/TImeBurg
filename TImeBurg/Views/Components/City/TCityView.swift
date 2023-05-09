//
//  TCityView.swift
//  TImeBurg
//
//  Created by Nebo on 18.01.2023.
//

import SwiftUI

struct TCityView: View {
    
    @ObservedObject var vm: TCityVM
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            ZStack(alignment: .bottom) {
                backgroundView()
                houses()
            }
            sidewalkView()
            roadView()
        }
    }
    
    @ViewBuilder
    func houses() -> some View {
        ZStack(alignment: .bottom) {
            ForEach(vm.buildings) {
                THouseView(vm: $0, isCanEdit: $vm.isCanEdit)
                    .zIndex(1.0/Double($0.line))
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    func backgroundView() -> some View {
        Image(vm.bgImage)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .overlay(
                Rectangle()
                    .fill(Color.blueViolet.opacity(0.3))
            )
    }
    
    @ViewBuilder
    func sidewalkView() -> some View {
        Rectangle()
            .fill(Color.lightGray)
            .frame(height: 20)
        Rectangle()
            .fill(Color.gray)
            .frame(height: 5)
    }
    
    @ViewBuilder
    func roadView() -> some View {
        ZStack(alignment: .center) {
            Rectangle()
                .fill(Color.darkGray)
                .frame(height: 80)
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

struct TCityView_Previews: PreviewProvider {
    static var previews: some View {
//        THomeView(vm: THomeViewModel(serviceFactory: TServicesFactory()))
        TCityView(vm: TCityVM(city: TCity(id: "qw", name: "qADa", image: "", bgImage: "bg12", spentTime: 123, comfortRating: 0.9, greenRating: 0.2, buildings: [ .init(image: "House8", timeExpenditure: 123, width: 70, line: 0, offsetX: 50)], history: [])))
    }
}
