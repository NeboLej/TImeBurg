//
//  Blur +.swift
//  TImeBurg
//
//  Created by Nebo on 17.03.2023.
//
import UIKit

extension UIView {
    func subView(forClass: AnyClass?) -> UIView? {
        return subviews.first { view in
            type(of: view) == forClass
        }
    }
}

extension UIVisualEffectView {
    
    var backDrop: UIView? {
        return subView(forClass: NSClassFromString("_UIVisualEffectBackdropView"))
    }
    
    var gaussianBlur: NSObject? {
        return backDrop?.value(key: "filters", filter: "gaussianBlur")
    }
    
    var saturation: NSObject? {
        return backDrop?.value(key: "filters", filter: "colorSaturate")
    }
    
    var gaussianBlurRadius: CGFloat {
        get {
            return gaussianBlur?.values?["inputRadius"] as? CGFloat ?? 0
        }
        set {
            gaussianBlur?.values?["inputRadius"] = newValue
            applyNewEffects()
        }
    }
    
    var saturationAmount: CGFloat {
        get {
            return saturation?.values?["inputAmount"] as? CGFloat ?? 0
        }
        set {
            saturation?.values?["inputAmount"] = newValue
            applyNewEffects()
        }
    }
    
    private func applyNewEffects() {
        backDrop?.perform(Selector(("applyRequestedFilterEffects")))
    }
}

extension NSObject {
    var values: [String: Any]? {
        get {
            return value(forKeyPath: "requestedValues") as? [String: Any]
        }
        set {
            setValue(newValue, forKey: "requestedValues")
        }
    }
    
    func value(key: String, filter: String) ->NSObject? {
        (value(forKey: key) as? [NSObject])?.first(where: { obj in
            return obj.value(forKeyPath: "filterType") as? String == filter
        })
    }
}

