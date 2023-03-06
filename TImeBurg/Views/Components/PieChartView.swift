//
//  PieChartView.swift
//  TImeBurg
//
//  Created by Nebo on 01.03.2023.
//

import SwiftUI

struct PieChartView: View {
    @Binding var tags: [TagInfoVM]
    @State var lineWidth: Double = 30
    private var fullTime: Int { tags.reduce(0) {  $0 + $1.time } }
    
    var body: some View {
        ZStack {
            ForEach(Array(tags.enumerated()), id: \.offset) { index, tag in
                Circle()
                    .trim(from: 0, to: Double(tag.time) / Double(fullTime))
                    .stroke(
                        tag.tag.color,
                        style: StrokeStyle(lineWidth: lineWidth))
                    .rotationEffect(.degrees(-90), anchor: .center)
                    .rotationEffect(.degrees(getAngle(id: index)))
            }
            .padding(lineWidth / 2)
        }
    }
    
    func getAngle(id: Int) -> Double {
        let time = tags.prefix(id).reduce(0) { $0 + $1.time }
        let angle = 360.0 * Double(time) / Double(fullTime)
        return angle
    }
}

struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        PieChartView(tags: .init(get: {
            [
             TagInfoVM(tag: .init(name: "name1", color: .pink), time: 100),
             TagInfoVM(tag: .init(name: "name2", color: .blue), time: 50),
             TagInfoVM(tag: .init(name: "name3", color: .red), time: 30),
             TagInfoVM(tag: .init(name: "name4", color: .yellow), time: 20) ]
        }, set: { _ in
            
        }) , lineWidth: 50)
    }
}
