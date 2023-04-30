//
//  HomeViewPhone.swift
//  TImeBurg
//
//  Created by Nebo on 30.04.2023.
//

import SwiftUI

struct HomeViewPhone: View {
    
    @ObservedObject var vm: THomeViewModel
    
    var body: some View {
        ZStack {
            THomeView(vm: vm)
            TagPickerView(vm: vm.tagPickerVM, currentTag: $vm.currentTag, isShow: $vm.tagPickerShow)
        }
    }
}

struct HomeViewPhone_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewPhone(vm: THomeViewModel(serviceFactory: TServicesFactory()))
    }
}
