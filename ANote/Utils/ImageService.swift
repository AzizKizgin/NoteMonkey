//
//  ImageService.swift
//  ANote
//
//  Created by Aziz Kızgın on 14.11.2023.
//

import Foundation
import SwiftUI

enum ImageError: Error {
    case imageDataConversion
    case fileWrite
}

struct ImageService{
    static func saveImage(image: UIImage?, imageName: String) throws {
        guard let image = image else {
            throw ImageError.imageDataConversion
        }
        if let imageData = image.jpegData(compressionQuality: 0.5) {
            let fileManager = FileManager.default
            let appName = "ANote"
            let imageUrl = "image_\(imageName).jpg"
            do {
                let documentsDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                let appFolderURL = documentsDirectory.appendingPathComponent(appName)
                
                if !fileManager.fileExists(atPath: appFolderURL.path) {
                    try fileManager.createDirectory(at: appFolderURL, withIntermediateDirectories: true, attributes: nil)
                }
                let fileURL = appFolderURL.appendingPathComponent(imageUrl)
                try imageData.write(to: fileURL)
                if let uiImage = UIImage(data: imageData){
                    ImageCache.shared.set(uiImage, forKey: imageName)
                }
                
            } catch {
                throw ImageError.fileWrite
            }
        } else {
            throw ImageError.imageDataConversion
        }
    }
    
    static func loadImage(imageName: String) async -> UIImage? {
        guard !imageName.isEmpty else {
            return nil
        }
        do {
            if let cachedImage = ImageCache.shared.get(forKey: imageName){
                return cachedImage
            }
            else {
                let fileManager = FileManager.default
                let appName = "ANote"
                let documentsDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                let appFolderURL = documentsDirectory.appendingPathComponent(appName)
                guard fileManager.fileExists(atPath: appFolderURL.path) else {
                    print("App folder does not exist")
                    return nil
                }
                let fileURL = appFolderURL.appendingPathComponent("image_\(imageName).jpg")
                guard fileManager.fileExists(atPath: fileURL.path) else {
                    print("Image file 'image_\(imageName).jpg' does not exist")
                    return nil
                }
                let imageData = try Data(contentsOf: fileURL)
                if let uiImage = UIImage(data: imageData) {
                    ImageCache.shared.set(uiImage, forKey: imageName)
                    return uiImage
                } else {
                    return nil
                }
                
            }
        } catch {
            return nil
        }
        
    }
}
