//
//  TagPickerVM.swift
//  TImeBurg
//
//  Created by Nebo on 19.03.2023.
//

import SwiftUI

protocol TagPickerListenerProtocol {
    func saveNewTag(name: String, colorHex: String)
}

class TagPickerVM: ObservableObject {
    
    @Published var statePickerView: StateTagView = .selected
    @Published var nameNewTag: String = ""
    @Published var colorNewTag: Color = .blueViolet
    @Published var tagsVM: [TagVM]
    
    private let parent: Any?
    
    init(tagsVM: [TagVM], parent: Any? = nil) {
        self.tagsVM = tagsVM
        self.parent = parent
    }
    
    enum StateTagView{
        case selected, new
    }
    
    func saveTag() {
        (parent as? TagPickerListenerProtocol)?.saveNewTag(name: nameNewTag, colorHex: colorNewTag.toHex())
    }
}
