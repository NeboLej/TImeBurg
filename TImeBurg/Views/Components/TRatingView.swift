//
//  TRatingView.swift
//  TImeBurg
//
//  Created by Nebo on 14.01.2023.
//

import SwiftUI
import Foundation

struct TRatingView: View {
    
    @State var rating: Double
    
    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<(Int(rating.rounded())), id: \.self) { _ in
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 10, height: 10)
                    .foregroundColor(Color.bananaYellow)
            }
            ForEach(0..<(5 - Int(rating.rounded())), id: \.self) { _ in
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 10, height: 10)
                    .foregroundColor(Color.lightGray)
            }
        }
        .modifier(WhiteCapsule())
    }
}

struct TRatingView_Previews: PreviewProvider {
    static var previews: some View {
        TRatingView(rating: 0.92)
    }
}
