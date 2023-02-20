//
//  ImageService.swift
//  TImeBurg
//
//  Created by Nebo on 20.02.2023.
//

import UIKit

protocol ImageServiceProtocol {
    func saveImage(imageName: String, image: UIImage) -> String
    func removeImage(path: String) -> Bool
    func getImage(fileName: String) -> UIImage?
}

class ImageService: ImageServiceProtocol {
    
    func saveImage(imageName: String, image: UIImage) -> String {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return "" }
        
        let fileURL = documentsDirectory.appendingPathComponent(imageName)
        guard let data = image.pngData() else { return "" } //image.jpegData(compressionQuality: 1) else { return false }
        print(fileURL)
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            _ = removeImage(path: fileURL.path)
        }
        
        do {
            try data.write(to: fileURL)
            return fileURL.path
        } catch let error {
            print("---Error saving file with error", error)
            return ""
        }
    }
    
    func removeImage(path: String) -> Bool {
        do {
            try FileManager.default.removeItem(atPath: path)
            print("---Removed old image")
            return true
        } catch let removeError {
            print("---Error couldn't remove file at path", removeError)
            return false
        }
    }
    
    func getImage(fileName: String) -> UIImage? {
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
