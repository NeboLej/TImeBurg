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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AllCitiesView_Previews: PreviewProvider {
    static var previews: some View {
        AllCitiesView(vm: AllCitiesVM(serviceFactory: TServicesFactory()))
    }
}
