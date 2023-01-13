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
                    lineView(title: "Количество зданий", rightView: Text("sd"))
                    lineView(title: "Самый популярный тег", rightView: TTagView(vm: TTagVM(name: "game", color: .green)))
                    lineView(title: "Озеленение", rightView: Button(action: {}, label: { Text("asdadadas") }))
                    lineView(title: "Комфорт", rightView: Text("dfv"))
                    lineView(title: "Уникальные постройки", rightView: Text("dfv"))
                }
            }
        }
        .padding(.horizontal, 20)
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
        TCityStatisticView(vm: TCityVM(city: TCity(name: "Tagil", numberOfPeople: 20, numberOfBuildings: 4, comfortRating: 5.0, greenRating: 3.4)))
    }
}
