
import Foundation
import SwiftUI

struct BodyMeasurement:Hashable,Codable {
    var height: Double
    var weight: Double
}

struct DogPost: Hashable,Codable,Identifiable {
    
    let id = UUID()
    var breedName: String
    var dogName: String
    var ageInMonths: Int
    var city: String
    var isAvailableForAdoption: Bool
    var isFavorite: Bool
    var ownersEmail: String
    var bodyMeasurements: BodyMeasurement
    var imageName: String?
    var description: String
    var postImage:UIImage?
    
    
    private enum CodingKeys: String, CodingKey {
        case breedName,dogName, ageInMonths,city,isAvailableForAdoption,isFavorite,ownersEmail,
        bodyMeasurements,imageName,description
    }
    
}

extension DogPost {
    var image:Image {
        if let loadedImage = postImage {
            return Image(uiImage: loadedImage)
        } else if let dogImageName = imageName {
            return ImageStore.shared.image(name:dogImageName)
        } else {
            return Image("Placeholder")
        }
    }
}
