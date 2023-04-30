//
//  TagStatisticsView.swift
//  TImeBurg
//
//  Created by Nebo on 01.03.2023.
//

import SwiftUI

struct TagStatisticsView: View {
    @ObservedObject var vm: TagStatisticsVM
    @State var width: CGFloat
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 20) {
                PieChartView(tags: $vm.tags )
                    .frame(width: width * 0.4)
                    .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 3)
                VStack {
                    ForEach(vm.tags) {
                        percentCell(tag: $0.tag, time: $0.time)
                    }
                }
            }
            .padding(.bottom, 20)
            
            VStack(alignment: .leading, spacing: 5) {
                ForEach(vm.tags) {
                    tagInfoCell(tag: $0.tag, time: $0.time)
                }
                if vm.isShowButton {
                    Button {
                        withAnimation { vm.showAll() }
                    } label: {
                        Text( vm.isAllTags ? "hide" : "show All")
                            .font(.custom(TFont.interRegular, size: 12))
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func percentCell(tag: TagVM, time: Int) -> some View {
        HStack(spacing: 20) {
            Rectangle()
                .fill(tag.color)
                .frame(width: 50, height: 4)
            Text(String(format: "%.01f%%", Double(time * 100) / Double(vm.fullTime)))
                .font(.custom(TFont.interRegular, size: 13))
        }
    }
    
    @ViewBuilder
    func tagInfoCell(tag: TagVM, time: Int) -> some View {
        HStack(spacing: 15) {
            TTagView(vm: tag)
            Spacer()
            Text("\(time) min")
                .font(.custom(TFont.interRegular, size: 12))
            let ch = time / 60 > 0 ? String("\(time / 60) h") : ""
            let min = time % 60 > 0 ? String("\(time % 60) min") : ""
            let text = ch.isEmpty ? "" : "\(ch) \(min)"
            Text(text)
                .font(.custom(TFont.interRegular, size: 12))
                .frame(width: 90)
        }
    }
}

struct TagStatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        TagStatisticsView(vm: .init(history: [
            History(date: Date(), time: 40, tag: .init(name: "name1", color: "ced")),
            History(date: Date(), time: 140, tag: .init(name: "name2", color: "236cfe")),
            History(date: Date(), time: 240, tag: .init(name: "name3", color: "0fd")),
        ]), width: 400)
    }
}
