//
//  View +.swift
//  TImeBurg
//
//  Created by Nebo on 20.02.2023.
//

import SwiftUI

extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view
 
        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear
 
        let renderer = UIGraphicsImageRenderer(size: targetSize)
 
        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }

    func canBeInteract(isCan : Bool) -> some View {
        self.overlay(alignment: .center) {
            Rectangle()
                .foregroundColor(.white.opacity(isCan ? 0 : 0.00001 ))
        }
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
    func endEditing() {
        UIApplication.shared.endEditing()
    }
}
