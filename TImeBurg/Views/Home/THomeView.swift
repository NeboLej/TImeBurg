//
//  THomeView.swift
//  TImeBurg
//
//  Created by Nebo on 09.01.2023.
//

import SwiftUI

struct THomeView: View {
    
    @ObservedObject var viewModel: THomeViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .foregroundColor(.blueViolet)
            .font(.custom(TFont.interRegular, size: 40))
    }
}

struct THomeView_Previews: PreviewProvider {
    static var previews: some View {
        THomeView(viewModel: THomeViewModel())
    }
}
