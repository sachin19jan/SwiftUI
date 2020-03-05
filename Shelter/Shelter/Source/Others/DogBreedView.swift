
import SwiftUI

struct DogBreedView: View {
    
    @ObservedObject var viewModel = DogBreedViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.breeds,id: \.self) { dogBreed in
                DogBreedPhotosView(dogBreed: dogBreed)
            } .navigationBarTitle("Breeds")
        }.navigationViewStyle(StackNavigationViewStyle())
            .onAppear() {
                self.viewModel.fetchImages()
        }
       
    }
}

struct DogBreedPhotosView: View {
    let dogBreed: DogBreed
    var body: some View {
        VStack(alignment: .leading) {
        Text(dogBreed.name.capitalized).font(.title)
            if dogBreed.images.count > 0 {
                HStack {
                    ForEach(dogBreed.images, id: \.self) {
                        image in
                        Image(uiImage: image).resizable().scaledToFit().cornerRadius(6)
                    }
                }
            } else {
                Text(dogBreed.error)
            }
            }.padding(.all)
    }
}

struct DogBreedView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DogBreedView().previewDevice("iPhone 8")
            DogBreedView().previewDevice("iPhone 4")
        }
    }
}
