//
//  CarImageView.swift
//  Constellation
//
//  Created by aydar.media on 22.07.2023.
//

import SwiftUI

struct CarImageView: View {
    var image: NSImage
    
    var body: some View {
        Image(nsImage: image)
            .resizable()
            .scaledToFill()
            .frame(width: 2, height: 102, alignment: .leading)  // TODO: this width is a joke
            .offset(x: -60, y: 28)
            .padding(.leading, -60)
            .padding(.top, -28)
    }
}

struct CarImageView_Previews: PreviewProvider {
    static var previews: some View {
        CarImageView(image: NSImage(named: "DefaultCar")!)
    }
}
