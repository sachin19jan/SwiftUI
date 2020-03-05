//
//  ContentView.swift
//  Shelter
//
//  Created by Sachin Bhardwaj on 25/02/20.
//  Copyright © 2020 Sachin Bhardwaj. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            PostBrowseView().tabItem {
                Image("Browse Icon")
                Text("Browse")
            }
            DogBreedView().tabItem {
                Image(systemName: "rectangle.stack.fill").font(.system(size: 25))
                Text("Breeds")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
        ContentView().previewDevice("iPhone 8")
            ContentView().environment(\.sizeCategory, .extraExtraExtraLarge).previewDevice("iPhone SE")
        }
    }
}
