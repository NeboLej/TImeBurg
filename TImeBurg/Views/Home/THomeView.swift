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
        ScrollView(.vertical, showsIndicators: false) {
            cityView()
            newHouseView()
                .padding(.top, -30)
        }
        .ignoresSafeArea(.all, edges: .top)
    }
    
    
    @ViewBuilder
    private func cityView() -> some View {
        VStack(alignment: .center, spacing: 0) {
            Rectangle()
                .fill(LinearGradient(colors: [.pink.opacity(0.8), .blueViolet, .brightNavyBlue], startPoint: .bottom, endPoint: .top))
                .frame(height: 300)
            Rectangle()
                .fill(Color.gray)
                .frame(height: 20)
            Rectangle()
                .fill(Color.black.opacity(0.85))
                .frame(height: 6)
            Rectangle()
                .fill(Color.black.opacity(0.8))
                .frame(height: 100)
        }

    }
    
    @ViewBuilder
    private func newHouseView() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                VStack(alignment: .center, spacing: 0) {
                    Text("New House")
                        .font(.custom(TFont.interRegular, size: 20))
                        .foregroundColor(.white)
                    Text("40")
                        .font(.custom(TFont.interRegular, size: 60))
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    Text("min")
                        .font(.custom(TFont.interRegular, size: 40))
                        .foregroundColor(.white)
                        .padding(.top, -15)
                }
                .padding(.leading, 25)
                Spacer()
                VStack(alignment: .leading, spacing: 0) {
                    Spacer()
                }
            }
            .padding(.top, 17)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 300)
        .background {
            LinearGradient(colors: [.blueViolet, .brightNavyBlue.opacity(0.53)], startPoint: .top, endPoint: .bottom)
        }
        .cornerRadius(25)
        .padding(.horizontal, 5)
    }
}

struct THomeView_Previews: PreviewProvider {
    static var previews: some View {
        THomeView(viewModel: THomeViewModel())
    }
}
