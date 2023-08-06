//
//  AppContentView.swift
//  Ursa
//
//  Created by aydar.media on 22.07.2023.
//

import SwiftUI

struct AppContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, Ursa!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppContentView()
    }
}
