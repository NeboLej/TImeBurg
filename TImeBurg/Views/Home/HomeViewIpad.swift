//
//  HomeViewIpad.swift
//  TImeBurg
//
//  Created by Nebo on 30.04.2023.
//

import SwiftUI

struct HomeViewIpad: View {
    
    @ObservedObject var vm: THomeViewModel
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                HStack(alignment: .top, spacing: 0) {
                    HistoryView(vm: vm.historyViewModel)
                        .frame(width: proxy.size.width * 0.4)
                    THomeView(vm: vm, width: (proxy.size.width + proxy.safeAreaInsets.leading + proxy.safeAreaInsets.trailing) * 0.6)
                        .frame(width: (proxy.size.width + proxy.safeAreaInsets.leading + proxy.safeAreaInsets.trailing) * 0.6)
                }
                TagPickerView(vm: vm.tagPickerVM, currentTag: $vm.currentTag, isShow: $vm.tagPickerShow)
            }
        }
    }
}

struct HomeViewIpad_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewIpad(vm: THomeViewModel(serviceFactory: TServicesFactory()))
    }
}
