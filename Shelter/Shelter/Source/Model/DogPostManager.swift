
import Foundation

let dogBreeds = ["labrador","husky","pug","lhasa","rottweiler","eskimo","germanshepherd","ridgeback","frise","pembroke","spaniel","bulldog"]
   

class DogPostsManager: ObservableObject {
    static let shared = DogPostsManager()
    @Published var dogPosts:[DogPost]
    
   
    private init(){
        dogPosts = load("ShelterData.json")
    }
    
    func add(post: DogPost){
        dogPosts.insert(post, at: 0)
    }
    
    func delete(post: DogPost){
        guard let index  = dogPosts.firstIndex(of:post) else {
            return
        }
        dogPosts.remove(at: index)
    }
    
    func addToFavorites(post: DogPost){
        guard let index  = dogPosts.firstIndex(of:post) else {
            return
        }
        var existingPost = dogPosts[index]
        existingPost.isFavorite = true
        dogPosts[index] = existingPost
    }
    
    func removeFromFavorites(post: DogPost){
        guard let index  = dogPosts.firstIndex(of:post) else {
            return
        }
        var existingPost = dogPosts[index]
        existingPost.isFavorite = false
        dogPosts[index] = existingPost
    }
    
}
