//
//  THouseVM.swift
//  TImeBurg
//
//  Created by Nebo on 18.01.2023.
//

import Foundation

protocol THouseListenerProtocol {
    func onHouseClick(id: String)
}

class THouseVM: ObservableObject {
    var id: String
    @Published var image: String
    @Published var timeExpenditure: Int
    @Published var width: Double
    @Published var line: Int
    @Published var offset = CGSize.zero
    private var parent: Any? = nil
    
    init(image: String, timeExpenditure: Int, width: Double, line: Int, offsetX: Double, id: String, parent: Any? = nil) {
        self.image = image
        self.timeExpenditure = timeExpenditure
        self.width = width
        self.line = line
        self.id = id
        self.parent = parent
        changedLine(st: 0)
        offset.width = offsetX
    }
    
    convenience init(house: THouse, parent: Any? = nil) {
        self.init(image: house.image, timeExpenditure: house.timeExpenditure, width: house.width, line: house.line, offsetX: house.offsetX, id: house.id, parent: parent)
    }
    
    func changedLine(st: Int) {
        line += st
        
        if line == 0 {
            offset.height = 0
        } else if line == 1 {
            offset.height = -30
        } else {
            offset.height = -60
        }
    }
    
    func move(offsetX: CGFloat) {
        offset = CGSize(width: offsetX, height: offset.height)
    }
    
    func onHouseClick() {
        (parent as? THouseListenerProtocol)?.onHouseClick(id: id)
    }
}

extension THouseVM: Identifiable, Hashable {
    var identifier: String {
        return UUID().uuidString
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    
    public static func == (lhs: THouseVM, rhs: THouseVM) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
