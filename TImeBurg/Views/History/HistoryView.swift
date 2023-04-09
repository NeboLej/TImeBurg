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
            if vm.currentCity.buildings.isEmpty {
                emptyState()
            } else {
                pageView()
            }
        }
        .background(Color.background)
    }
    
    @ViewBuilder
    func emptyState() -> some View {
        VStack {
            Spacer()
            Text("В этом месяце у вас еще не было активности")
                .font(.custom(TFont.interRegular, size: 20))
                .multilineTextAlignment(.center)
                .foregroundColor(.outerSpace)
                .padding()
                .offset(x: -26, y: -30)
            Spacer()
        }
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
        VStack(spacing: 1) {
            ForEach(vm.getHistory()) { dayHistory in
                Section {
                    ForEach(dayHistory.history) {
                        historyCell(tag: $0.tag, time: $0.time)
                    }
                } header: {
                    historyHeader(date: dayHistory.date, fullTime: dayHistory.fullTime)
                }
            }
        }
    }
    
    @ViewBuilder
    func historyHeader(date: Date, fullTime: String) -> some View {
        HStack {
            Text(date.toReadableDate())
            Spacer()
            Text(fullTime)
        }
        .font(.custom(TFont.interRegular, size: 14))
        .foregroundColor(Color.outerSpace)
        .padding(.top, 15)
        .padding(.bottom, 3)
        .padding(.horizontal, 10)
    }
    
    @ViewBuilder
    func historyCell(tag: TagVM, time: Int) -> some View {
        HStack(spacing: 0) {
           Rectangle()
                .fill(tag.color)
                .frame(width: 10)
            Text("\(time) min")
                .font(.custom(TFont.interRegular, size: 16))
                .foregroundColor(Color.outerSpace)
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
                Image(uiImage: vm.currentCity.image ?? UIImage(named: "testCity")!)
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
    func tagsView() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 7) {
                ForEach(Array(vm.month.enumerated()), id: \.offset) { index, text in
                    tagCell(text: text, tag: index)
                }
            }
        }.background(Color.darkViolet)
    }
    
    @ViewBuilder
    func tagCell(text: String, tag: Int) -> some View {
        Button {
            withAnimation {
                vm.selectMonth(index: tag)
            }
        } label: {
            Text(text)
                .foregroundColor(Color.outerSpace)
                .padding(10)
                .aspectRatio(contentMode: .fill)
                .rotationEffect(.degrees(-90), anchor: .center)
        }
        .frame(width: 26, height: 150)
        .background( tag == vm.selectedMonth ? Color.background : Color(hex: vm.getMonthColor(index: tag)))
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(vm: HistoryViewModel(serviceFactory: TServicesFactory()))
    }
}
