//
//  HistoryView.swift
//  TImeBurg
//
//  Created by Nebo on 26.02.2023.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var vm: HistoryViewModel
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            tagsView()
            Spacer()
            pageView()
        }
        .background(Color.background)
    }
    
    @ViewBuilder
    func pageView() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            photoView()
            TagStatisticsView(vm: vm.tagStatisticsVM)
                .padding(10)
            historyTable()
                .padding(.horizontal, 10)
        }
    }
    
    @ViewBuilder
    func historyTable() -> some View {
        VStack(alignment: .leading, spacing: 1) {
            ForEach(vm.getHistory()) { dayHistory in
                Section {
                    ForEach(dayHistory.history) {
                        historyCell(tag: $0.tag, time: $0.time)
                    }
                } header: {
                    Text(dayHistory.date.toReadableDate())
                        .font(.custom(TFont.interRegular, size: 14))
                        .foregroundColor(.black.opacity(0.6))
                        .padding(.top, 15)
                        .padding(.bottom, 3)
                        .padding(.leading, 10)
                }
            }
        }
    }
    
    @ViewBuilder
    func historyCell(tag: TagVM, time: Int) -> some View {
        HStack(spacing: 0) {
           Rectangle()
                .fill(tag.color)
                .frame(width: 10)
            Text("\(time) min")
                .foregroundColor(Color(hex: "5A5A5A"))
                .padding(.horizontal, 10)
            Spacer()
            TTagView(vm: tag)
                .padding(10)
        }
        .frame(maxWidth: .infinity)
        .background(Color(hex: "D9D9D9"))
        .cornerRadius(20, corners: [.bottomRight, .topRight])
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
                HStack {
                    Text(vm.month[vm.selectedMonth].uppercased())
                        .font(.custom(TFont.interRegular, size: 18))
                    Spacer()
                    Text(vm.getFullTime())
                        .font(.custom(TFont.interRegular, size: 16))
                        .padding(.trailing, 15)
                }
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
        .background( tag == vm.selectedMonth ? Color.background : Color(hex: vm.monthColors.randomElement()!))
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
        HistoryView(vm: HistoryViewModel())
    }
}
