//
//  TestView.swift
//  TImeBurg
//
//  Created by Nebo on 20.02.2023.
//

import SwiftUI
import UIKit


struct TestView: View {
    
    @ObservedObject var vm = TestVM()
    
    var textView: some View {
        Circle()
            .fill(Color.mellowApricot)
//            .shadow(color: .black.opacity(0.3), radius: 3, x: 3, y: 3)
            .frame(width: 350, height: 350)
    }

    var body: some View {
        VStack {
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

class TestVM: ObservableObject {
    @Published var image: UIImage = UIImage(named: "House1")!
    
    func saveImage(image: UIImage) {
//        self.image = image
//        saveImage(imageName: "TestImage", image: image)
//        self.image = loadImageFromDiskWith(fileName: "TestImage") ?? UIImage(named: "testCity")!
    }

}


