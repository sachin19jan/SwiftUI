//
//  PostDetailView.swift
//  Shelter
//
//  Created by Sachin Bhardwaj on 25/02/20.
//  Copyright © 2020 Sachin Bhardwaj. All rights reserved.
//

import SwiftUI

struct PostDetailView: View {
    var dogPost: DogPost
    var body: some View {
        NavigationView {
        Form {
            dogPost.image.resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color(.systemFill))
            
            Section(header: Text("Dog Traits")) {
                HStack {
                    Text("Dog Name")
                    Spacer()
                    Text(dogPost.dogName)
                }
                HStack {
                    Text("Breed Name")
                    Spacer()
                    Text(dogPost.breedName)
                }
                HStack {
                    Text("Age")
                    Spacer()
                    Text(String(dogPost.ageInMonths))
                }
            }
            Section(header: Text("Measurements")) {
                HStack {
                    Text("Height")
                    Spacer()
                    Text("\(dogPost.bodyMeasurements.height)")
                }
                HStack {
                    Text("Weight")
                    Spacer()
                    Text(String(dogPost.bodyMeasurements.weight))
                }
            }
            if dogPost.isAvailableForAdoption {
            Section(header: Text("Adoption")) {
                HStack {
                    Text("Owner's Email")
                    Spacer()
                    Text(dogPost.ownersEmail)
                }
                HStack {
                    Text("City")
                    Spacer()
                    Text(dogPost.city)
                }
            }
            }
        }
        .navigationBarTitle(Text(dogPost.breedName),displayMode:.inline)
        .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView(dogPost: DogPost(breedName: "pug", dogName: "Maxx", ageInMonths: 3, city: "Delhi", isAvailableForAdoption: true, isFavorite: false, ownersEmail: "aa@aa.com", bodyMeasurements: BodyMeasurement(height: 72.5, weight: 12.0), imageName: nil, description: "Maxx is a lovely dog", postImage: nil))
    }
}
