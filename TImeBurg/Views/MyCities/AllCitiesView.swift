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
            Text("All Cities")
                .padding(.bottom, 6)
                .font(.custom(TFont.interRegular, size: 20))
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .background( LinearGradient(colors: [ .blueViolet.opacity(0.8), .brightNavyBlue.opacity(0.5)], startPoint: .leading, endPoint: .trailing))
    }
    
    @ViewBuilder
    func cityCell(city: TCityPreviewVM) -> some View {
        ZStack(alignment: .top) {
            Image(city.iamge)
                .resizable()
                .scaledToFit()
            HStack {
                Text(city.name)
                    .font(.custom(TFont.interRegular, size: 18))
                    .foregroundColor(.white)
                Spacer()
                TPeopleCounterView(count: .init(get: { city.spentTime / 10 }, set: { _ in }))
                    .frame(width: 80)
            }
            .padding(10)
            .background( LinearGradient(colors: [ .blueViolet.opacity(0.8), .brightNavyBlue.opacity(0.5)], startPoint: .leading, endPoint: .trailing))
        }
    }
}

struct AllCitiesView_Previews: PreviewProvider {
    static var previews: some View {
        AllCitiesView(vm: AllCitiesVM(serviceFactory: TServicesFactory()))
    }
}
