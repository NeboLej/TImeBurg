//
//  TCityStatisticView.swift
//  TImeBurg
//
//  Created by Nebo on 13.01.2023.
//

import SwiftUI

struct TCityStatisticView: View {
    
    @ObservedObject var vm: TCityVM
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(vm.name)
                    .foregroundColor(.white)
                    .font(.custom(TFont.interRegular, size: 20))
                Spacer()
                TPeopleCounterView(count: vm.numberOfPeople)
                    .frame(width: 90)
            }
            .padding(.top, 22)
            
            HStack {
                VStack(spacing: 9) {
                    lineView(title: "Количество зданий", rightView: Text("\(vm.buildings.count)").modifier(WhiteCapsule()))
                    lineView(title: "Самый популярный тег", rightView: TTagView(vm: TTagVM(name: "game", color: .green)))
                    lineView(title: "Озеленение", rightView: TRatingView(rating: vm.greenRating))
                    lineView(title: "Комфорт", rightView: TRatingView(rating: vm.comfortRating))
                    lineView(title: "Уникальные постройки", rightView: Text("\(vm.getUnicalBuildingsCount())").modifier(WhiteCapsule()))
                }
                VStack(alignment: .center,  spacing: 9) {
                    Image(vm.getTopBuilding()?.image ?? "")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
//                        .padding(.leading, 40)
//                        .padding(.trailing, 10)
                    Text("Самое большое здание")
                        .modifier(WhiteCapsule())
                }
            }
            .padding(.top, 15)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 40)
        .background {
            LinearGradient(colors: [.blueViolet, .brightNavyBlue.opacity(0.53)], startPoint: .top, endPoint: .bottom)
        }
        .cornerRadius(25)
    }
    
    @ViewBuilder
    func lineView(title: String, rightView: some View) -> some View {
        HStack {
            Text(title)
                .foregroundColor(.white)
                .font(.custom(TFont.interRegular, size: 12))
            Spacer()
            rightView
        }
    }
}

struct TCityStatisticView_Previews: PreviewProvider {
    static var previews: some View {
        TCityStatisticView(vm: TCityVM(city: .init(id: "sad", name: "Predsfs", image: "", spentTime: 123, comfortRating: 0.5, greenRating: 0.7, buildings: [], history: [:])))
    }
}
