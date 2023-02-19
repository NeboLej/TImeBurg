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
            Image(uiImage: vm.image)
                .resizable()
//                .scaledToFit()
                .frame(width: 50, height: 50)
            
//            textView

            Button("Save to image") {
                let image = textView.snapshot()
                
                vm.saveImage(image: image)
                
//                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                
            }
        }
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
        saveImage(imageName: "TestImage", image: image)
        self.image = loadImageFromDiskWith(fileName: "TestImage") ?? UIImage(named: "testCity")!
    }
    
    func saveImage(imageName: String, image: UIImage) {
     guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

        let fileName = imageName
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 1) else { return }
        print(fileURL)

        //Checks if file exists, removes it if so.
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
            } catch let removeError {
                print("couldn't remove file at path", removeError)
            }
        }

        do {
            try data.write(to: fileURL)
        } catch let error {
            print("error saving file with error", error)
        }
    }


    func loadImageFromDiskWith(fileName: String) -> UIImage? {

      let documentDirectory = FileManager.SearchPathDirectory.documentDirectory

        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)

        if let dirPath = paths.first {
            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
            let image = UIImage(contentsOfFile: imageUrl.path)
            return image

        }

        return nil
    }
}

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
}
