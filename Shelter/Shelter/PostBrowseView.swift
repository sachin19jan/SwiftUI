//
//  PostBrowseView.swift
//  Shelter
//
//  Created by Sachin Bhardwaj on 25/02/20.
//  Copyright © 2020 Sachin Bhardwaj. All rights reserved.
//

import SwiftUI

struct PostBrowseView: View {
    @State private var showNewPost = false
    @ObservedObject var postManager = DogPostsManager.shared
    var body: some View {
        NavigationView{
            List(postManager.dogPosts) { dogPost in
                NavigationLink(destination: PostDetailView(dogPost: dogPost)) {
                    DogCardView(dogPost: dogPost).contextMenu {
                        self.favoriteMenuButton(for: dogPost)
                        self.deleteMenuButton(for: dogPost)
                    }
                }
            }.navigationBarTitle("Browse")
                .navigationBarItems(
                    trailing: addButton()
                        .sheet(isPresented:$showNewPost) {
                        NewPostView()
                    }
            )
        }
    }
    
    func favoriteMenuButton(for dogPost:DogPost) -> some View {
        Button(action: {
            if dogPost.isFavorite {
                self.postManager.removeFromFavorites(post: dogPost)
            }else {
                self.postManager.addToFavorites(post: dogPost)
            }
        }) {
            Text(dogPost.isFavorite ? "Remove from Favorites":"Add to Favorites")
            Image(systemName:dogPost.isFavorite ? "heart.slash" : "heart")
        }
    }
    
    func deleteMenuButton(for dogPost:DogPost) -> some View {
        Button(action: {
            self.postManager.delete(post: dogPost)
            
        }) {
            Text("Delete Post").foregroundColor(.red)
            Image(systemName:"trash")
        }
    }
    func addButton() -> some View {
        Button(action: {
            //show the sheet here
            self.showNewPost = true
        }) {
            Image(systemName: "plus")
                .font(.title)
        }
    }
}

struct PostBrowseView_Previews: PreviewProvider {
    static var previews: some View {
        PostBrowseView()
    }
}

struct DogCardView: View {
    let dogPost:DogPost
    var body: some View {
        VStack(alignment: .leading, spacing: 10.0){
            dogPost.image
                .resizable()
                .scaledToFit()
            HStack {
                Text(dogPost.dogName.capitalized)
                    .font(.headline)
                    .padding([.leading])
                
                if dogPost.isFavorite {
                    Spacer()
                    Image(systemName: "heart.fill")
                        .foregroundColor(Color(UIColor.systemPink))
                        .padding([.trailing])
                }
            }
            
            Text(dogPost.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding([.leading,.bottom,.trailing])
            
        }
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10.0)
        .shadow(radius: 10.0)
        .padding([.top,.bottom])
    }
}
