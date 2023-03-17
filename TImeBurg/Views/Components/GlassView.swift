//
//  GlassView.swift
//  TImeBurg
//
//  Created by Nebo on 17.03.2023.
//

import SwiftUI

struct GlassView<Content>: View where Content : View {
    
    @State private var blurView: UIVisualEffectView = .init()

    var content: Content
    var blurRadius: CGFloat
    var saturation: CGFloat
    var strokeGradient: LinearGradient
    
    init(blurRadius: CGFloat = 5, saturation: CGFloat = 1.5, strokeGradient: LinearGradient = LinearGradient(colors: [ .white.opacity(0.6), .white.opacity(0.15), .blueViolet.opacity(0.2), .blueViolet.opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing), @ViewBuilder content: () -> Content) {
        self.content = content()
        self.blurRadius = blurRadius
        self.saturation = saturation
        self.strokeGradient = strokeGradient
    }
    
    var body: some View {
        ZStack {
            ZStack {
                CustomBlurView(effect: .systemUltraThinMaterialLight) { view in
                    blurView = view
                    blurView.gaussianBlurRadius = blurRadius
                    blurView.saturationAmount = saturation
                }
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .stroke(strokeGradient, lineWidth: 2)
                
            }
            .shadow(color: .black.opacity(0.15), radius: 3, x: -5, y: 5)
            .shadow(color: .black.opacity(0.15), radius: 3, x: 5, y: -5)
            .overlay(content: {
                content
//                    .padding(20)
//                    .shadow(radius: 5)
//                    .blendMode(.overlay)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            })
        }
    }
}

fileprivate struct CustomBlurView: UIViewRepresentable {
    
    var effect: UIBlurEffect.Style
    var onCange: (UIVisualEffectView) -> ()
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: effect))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        DispatchQueue.main.async {
            onCange(uiView)
        }
    }
}

struct WSGlassView_Previews: PreviewProvider {
    static var previews: some View {
        THomeView(vm: THomeViewModel(serviceFactory: TServicesFactory()))
    }
}
