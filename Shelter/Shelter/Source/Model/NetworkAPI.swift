import Foundation
import Combine
import SwiftUI

struct DogBreedPhotoURLList: Hashable,Codable,Identifiable {
    
    let id = UUID()
    let imageURLs:[String]
    
    private enum CodingKeys: String, CodingKey {
        case imageURLs = "message"
    }
}


struct API {
    
    static let maxImages: Int = 3
    
    enum NetworkError: Error {
        
        case addressUnreachable(URL)
        case invalidResponse
        case incorrectData

        var errorDescription: String? {
          switch self {
          case .invalidResponse: return "Invalid Server Response."
          case .addressUnreachable(let url): return "\(url.absoluteString) is unreachable."
          case .incorrectData: return "Incorrect Image Data."

          }
        }
    }
    
    
    /// API endpoints.
    enum EndPoint {
        static let baseURLString =  "https://dog.ceo/api/breed/%@/images/random/\(API.maxImages)"
        
        case dogBreedImagesURL(String)
        case dogBreedImage(String)
        
        var url: URL {
          switch self {
          case .dogBreedImagesURL(let breedName):
            let finalURL = String(format: EndPoint.baseURLString, arguments: [breedName])
            return URL(string: finalURL)!
            
          case .dogBreedImage(let breedImageURL):
            return URL(string: breedImageURL)!
          }
        }
    }
    
    private let decoder = JSONDecoder()
    private let apiQueue = DispatchQueue(label: "Shelter", qos: .default, attributes: .concurrent)
        
    func imageFromURL(imageURL: String) -> AnyPublisher<UIImage,Error> {
        
        URLSession.shared.dataTaskPublisher(for: EndPoint.dogBreedImage(imageURL).url)
          .receive(on: apiQueue)
          .tryMap { data, _ in
              guard let image = UIImage(data: data) else {
                  throw NetworkError.incorrectData
              }
              return image
          }
          .eraseToAnyPublisher()
    }
    
    func mergedImages(imageURLs: [String]) -> AnyPublisher<UIImage, Error> {
      let images = Array(imageURLs)
      precondition(!images.isEmpty)

      let initialPublisher = imageFromURL(imageURL:images[0])
      let remainder = Array(images.dropFirst())
      
      return remainder.reduce(initialPublisher) { (combined, id) -> AnyPublisher<UIImage, Error> in
        return combined.merge(with: imageFromURL(imageURL:id))
          .eraseToAnyPublisher()
      }
    }
    
    func loadImages(dogBreedName: String) -> AnyPublisher<[UIImage], Error> {
        return URLSession.shared.dataTaskPublisher(for: EndPoint.dogBreedImagesURL(dogBreedName).url)
          .receive(on: apiQueue)
          .map { $0.data }
          .decode(type: DogBreedPhotoURLList.self, decoder: decoder)
          .mapError { error in
            switch error {
            case is URLError:
              return NetworkError.addressUnreachable(EndPoint.dogBreedImagesURL(dogBreedName).url)
              default: return NetworkError.invalidResponse
            }
          }
          .filter { !$0.imageURLs.isEmpty }
          .map { $0.imageURLs }
          .flatMap { images in
            return self.mergedImages(imageURLs: images)
         }
        .collect()
        .eraseToAnyPublisher()
    }
}




