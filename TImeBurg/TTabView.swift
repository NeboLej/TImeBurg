//
//  ContentView.swift
//  TImeBurg
//
//  Created by Nebo on 09.01.2023.
//

import SwiftUI

struct TTabView: View {
    
    @State private var selectionTab = 0
    @ObservedObject var vm: TTabViewModel
    
    init(vm: TTabViewModel) {
        self.vm = vm
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $vm.currentTab) {
                AllCitiesView(vm: vm.getAllCitiesViewModel())
                    .tag(Tab.list)
                THomeView(vm: vm.getHomeViewModel())
                    .tag(Tab.home)
                Text("gear")
                    .tag(Tab.gear)
            }
            CustomTabBarView(currentTab: $vm.currentTab)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TTabView(vm: TTabViewModel(servicesFactory: TServicesFactory()))
    }
}

