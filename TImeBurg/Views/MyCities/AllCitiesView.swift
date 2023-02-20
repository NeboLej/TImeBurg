//
//  AllCitiesView.swift
//  TImeBurg
//
//  Created by Nebo on 02.02.2023.
//

import SwiftUI

struct AllCitiesView: View {
    
    @ObservedObject var vm: AllCitiesVM
    
    var body: some View {
        VStack(spacing: 0) {
            header()
            ScrollView {
                ForEach(vm.citiesPreview) { city in
                    cityCell(city: city)
                }
                .padding(.top, 10)
            }
        }
    }
    
    @ViewBuilder
    func header() -> some View {
        HStack {
            Image("MyCitiesLogo")
                .padding(.horizontal, 16)
                .padding(.bottom, 10)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background( LinearGradient(colors: [ .blueViolet, .blueViolet.opacity(0.7)], startPoint: .top, endPoint: .bottom))
    }
    
    @ViewBuilder
    func cityCell(city: TCityPreviewVM) -> some View {
        ZStack(alignment: .top) {
//            Image(city.iamge)
            Image(uiImage: city.image ?? UIImage(systemName: "house")!)
                .resizable()
                .scaledToFit()
            HStack {
                Text(city.name)
                    .font(.custom(TFont.interRegular, size: 18))
                    .foregroundColor(.black)
                Spacer()
                TPeopleCounterView(count: .init(get: { city.spentTime / 10 }, set: { _ in }))
                    .frame(width: 80)
            }
            .padding(10)
            .background( Color.mellowApricot)
            .shadow(color: .black.opacity(0.4), radius: 3, x: 0, y: 3)
        }
    }
}

struct AllCitiesView_Previews: PreviewProvider {
    static var previews: some View {
        AllCitiesView(vm: AllCitiesVM(serviceFactory: TServicesFactory()))
    }
}
