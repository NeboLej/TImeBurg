//
//  TCircleProgressView.swift
//  TImeBurg
//
//  Created by Nebo on 23.01.2023.
//

import SwiftUI

struct TCircleProgressView: View {
    let progress: Float
    
    var body: some View {
        
        ZStack {
            Circle()
                .stroke(
                    Color.white,
                    lineWidth: 10
                )
                .shadow(color: .darkGray.opacity(0.4), radius: 0, x: 0, y: 4)
                
            Circle()
                .trim(from: 0, to: Double(progress))
                .stroke(
                     Color.mellowApricot,
                     style: StrokeStyle(
                         lineWidth: 10,
                         lineCap: .round
                     ))
                .rotationEffect(.degrees(-90))
                .animation(.linear(duration: 1), value: progress)
//            Rectangle()
//                .fill(Color.red)
//                .frame(height: 1)
//            Rectangle()
//                .fill(Color.red)
//                .frame(width: 1)
            Image("ArrowHome")
                .resizable()
                .scaledToFit()
                .overlay(alignment: .bottom, content: {
                    Circle()
                        .fill(Color.white)
                        .frame(height: 20)
                        .offset(y: 10)
                })
                .frame(height: 90)
                .rotationEffect(.init(degrees: Double(progress) * 360), anchor: .bottom)
            
                .offset(y: -45)
                .shadow(color: .darkGray.opacity(0.4), radius: 0, x: 0, y: 4)
                .animation(.linear(duration: 1), value: progress)

                
        }
        .frame(width: 130, height: 130)

    }
}

struct TCircleProgressView_Previews: PreviewProvider {
    static var previews: some View {
        TCircleProgressView(progress: 0.7)
    }
}
