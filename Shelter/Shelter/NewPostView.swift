//
//  NewPostView.swift
//  Shelter
//
//  Created by Sachin Bhardwaj on 25/02/20.
//  Copyright © 2020 Sachin Bhardwaj. All rights reserved.
//

import SwiftUI

struct NewPostView: View {
    var dogImage: Image {
        if let image = selectedImage {
            return Image(uiImage: image)
        } else {
            return Image("Placeholder")
        }
    }
    @State private var dogHeight = ""
    @State private var dogWeight = ""
    @State private var dogAge = ""
    @State private var contactEmail = ""
    @State private var city = ""
    @State private var dogName = ""
    @State private var dogDescription = ""
    @State private var selectedBreed = ""
    @State private var adoptionToggle: Bool = true
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Dog Photo")) {
                    Button(action: {
                        self.isImagePickerPresented = true
                    }) {
                        VStack{
                            dogImage.resizable()
                                .scaledToFit()
                                .foregroundColor(Color(.systemFill))
                            Text("Choose Image")
                                .fontWeight(.bold)
                                .foregroundColor(Color(.blue))
                        }
                    }.buttonStyle(PlainButtonStyle())
                    .sheet(isPresented: self.$isImagePickerPresented) {
                        ImagePicker(originalImage: self.$selectedImage, presentationMode: self.$isImagePickerPresented)
                    }
                }
                Section(header: Text("Dog Traits")) {
                    HStack {
                        Text("Height in cm")
                        TextField("cm", text: $dogHeight)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Weight in kg")
                        TextField("kg", text: $dogWeight)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Age in Months")
                        TextField("Months", text: $dogAge)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    Picker(selection: $selectedBreed, label: Text("Breed")) {
                        ForEach(dogBreeds, id: \.self) {
                            breedName in
                            Text(breedName.capitalized)
                        }.navigationBarTitle("Dog breeds")
                    }.navigationBarTitle("Add Dog Details")
                }
                Section(header: Text("Adoption")) {
                    Toggle(isOn: $adoptionToggle) {
                        Text("Available for Adoption")
                    }
                    if adoptionToggle {
                        HStack {
                            Text("Contact Email")
                            TextField("appleaccelerator@apple.com", text: $contactEmail)
                                .keyboardType(.emailAddress)
                                .multilineTextAlignment(.trailing)
                        }
                        HStack {
                            Text("City")
                            TextField("e.g. Bangalore", text: $city)
                                .keyboardType(.default)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                }
                Section(header: Text("")) {
                    HStack {
                        Text("Name")
                        TextField("Dog Name", text: $dogName)
                            .keyboardType(.emailAddress)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        TextField("Write about your dog", text: $dogDescription)
                            .keyboardType(.default)
                            .multilineTextAlignment(.leading)
                    }
                }
            }
        .modifier(KeyboardHeight())
        .navigationBarTitle(Text("New Post"),displayMode:.inline)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Text ("Cancel")
        }), trailing: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
            
            self.addNewPost()
            
        }, label: {
            Text ("Done")
        }))
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    func addNewPost() {
        let dogPost = DogPost(breedName: selectedBreed, dogName: dogName, ageInMonths: Int(dogAge) ?? 0, city: city, isAvailableForAdoption: adoptionToggle, isFavorite: false, ownersEmail: contactEmail, bodyMeasurements: BodyMeasurement(height: Double(dogHeight) ?? 0, weight: Double(dogWeight) ?? 0), imageName: nil, description: dogDescription, postImage: self.selectedImage)
        
        DogPostsManager.shared.add(post: dogPost)
    }
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView()
    }
}
