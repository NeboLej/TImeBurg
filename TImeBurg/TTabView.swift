//
//  ContentView.swift
//  TImeBurg
//
//  Created by Nebo on 09.01.2023.
//

import SwiftUI

struct TTabView: View {
    
    @State private var selectionTab = 0
    @ObservedObject var viewModel: TTabViewModel
    
    var body: some View {
        TabView(selection: $selectionTab) {
            THomeView(vm: THomeViewModel())
                .tabItem {
                Image(systemName: "home")
                Text("home")
            }.tag(0)
            TProgressView(vm: .init(minutes: 1.0))
                .tabItem {
                Image(systemName: "home")
                Text("home")
            }.tag(1)
        }
//        .onAppear() {
//            UITabBar.appearance().unselectedItemTintColor = UIColor.gray
//        }
//        .accentColor(Color("backgroundFirst"))
        .font(.headline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TTabView(viewModel: TTabViewModel(servicesFactory: TServicesFactory()))
    }
}


