//
//  UIApplication + .swift
//  TImeBurg
//
//  Created by Nebo on 20.03.2023.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
