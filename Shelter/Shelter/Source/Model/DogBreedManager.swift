import Foundation
import SwiftUI
import Combine

struct DogBreed : Hashable,Identifiable {
    let id = UUID()
    let name:String
    let images : [UIImage]
    let error: String
}

class DogBreedViewModel: ObservableObject {
    
    @Published var breeds: [DogBreed] = []
    
    private let api = API()
    private var subscriptions = Set<AnyCancellable>()
    
    func fetchImages() {
        
        if breeds.count > 0 {
            return
        }
        
        for dogBreedName in dogBreeds {
            api.loadImages(dogBreedName: dogBreedName)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    
                }, receiveValue: {
                    [weak self] images in
                    let dogBreed = DogBreed(name: dogBreedName, images: images, error: "")
                    self?.breeds.append(dogBreed)
                })
                .store(in: &subscriptions)
        }
        
    }
}
