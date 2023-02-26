//
//  HistoryView.swift
//  TImeBurg
//
//  Created by Nebo on 26.02.2023.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var vm: HistoryVM
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            tagsView()
            Spacer()
            pageView()
        }
        .background(.gray.opacity(0.4))
    }
    
    @ViewBuilder
    func pageView() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            photoView()
            TagStatisticsView(vm: vm.tagStatisticsVM)
                .padding(10)
        }
    }
    
    @ViewBuilder
    func photoView() -> some View {
        ZStack {
            Rectangle()
                .fill(.white)
            VStack(alignment: .leading) {
                Image("testCity")
                    .resizable()
                    .scaledToFit()
                    .padding(10)
                Text(vm.month[vm.selectedMonth].uppercased())
                    .padding(.leading, 15)
                    .padding(.bottom, 20)
            }
        }
        
        .rotationEffect(.degrees(3))
        .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 5)
        .padding(10)
    }
    
    @ViewBuilder
    func tagCell(text: String, tag: Int) -> some View {
        Button {
            withAnimation {
                vm.selectMonth(index: tag)
            }
        } label: {
            Text(text)
                .foregroundColor(.black)
                .padding(10)
                .aspectRatio(contentMode: .fill)
                .rotationEffect(.degrees(-90), anchor: .center)
        }
        .frame(width: 26, height: 150)
        .background( tag == vm.selectedMonth ? .white : Color(hex: vm.monthColors.randomElement()!))
    }
    
    @ViewBuilder
    func tagsView() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 7) {
                    ForEach(Array(vm.month.enumerated()), id: \.offset) { index, text in
                    tagCell(text: text, tag: index)
                }
            }
        }.background(Color(hex: "23204D"))
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(vm: HistoryVM())
    }
}


struct TagStatisticsView: View {
    @ObservedObject var vm: TagStatisticsVM
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            VStack(alignment: .leading, spacing: 5) {
                ForEach(vm.tags) {
                    tagInfoCell(tag: $0.tag, time: $0.time)
                }
                
                if vm.isShowButton {
                    Button {
                        withAnimation {
                            vm.showAll()
                        }
                    } label: {
                        Text( vm.isAllTags ? "hide" : "show All")
                            .font(.custom(TFont.interRegular, size: 12))
                    }
                }
            }
            Circle()
                .fill(.pink.opacity(0.4))
                .frame(width: 140)
        }
    }
    
    @ViewBuilder
    func tagInfoCell(tag: TagVM, time: Int) -> some View {
        HStack {
            TTagView(vm: tag)
            Spacer()
            Text("\(time) min")
                .font(.custom(TFont.interRegular, size: 10))
        }
    }
}
