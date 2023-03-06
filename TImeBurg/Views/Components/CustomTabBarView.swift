//
//  CustomTabBarView.swift
//  TImeBurg
//
//  Created by Nebo on 18.02.2023.
//

import SwiftUI

struct CustomTabBarView: View {
    @Binding var currentTab: Tab
    @State private var yOffset: CGFloat = 0
    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Button {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            currentTab = tab
                            yOffset = -80
                        }
                        withAnimation(.easeInOut(duration: 0.1).delay(0.1)) {
                            yOffset = 0
                        }
                    } label: {
                        Image(systemName: tab.rawValue)
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .offset(y: currentTab == tab ? -4 : 0)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(alignment: .leading) {
                Circle()
                    .stroke(
                         Color.mellowApricot,
                         style: StrokeStyle(
                             lineWidth: 7,
                             lineCap: .round
                         ))
                    .frame(width: 65, height: 65)
                    .offset(x: 11, y: -5)
                    .offset(x: indicatorOffset(width: width), y: yOffset)
                    .shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 6)
            }
        }
        .frame(height: 35)
        .padding(.bottom, 10)
        .padding([.horizontal, .top])
        .background(LinearGradient(colors: [Color.brightNavyBlue, Color.blueViolet], startPoint: .leading, endPoint: .trailing))
    }
    
    func indicatorOffset(width: CGFloat) -> CGFloat {
        let index = CGFloat(getIndex())
        if index == 0 { return 0 }
        
        let buttonWidth = width / CGFloat(Tab.allCases.count)
        return index * buttonWidth
    }
    
    func getIndex() -> Int {
        switch currentTab {
            case .list:
                return 0
            case .home:
                return 1
            case .history:
                return 2
            case .gear:
                return 3
        }
    }
}

struct CustomTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TTabView(vm: TTabViewModel(servicesFactory: TServicesFactory()))
    }
}
