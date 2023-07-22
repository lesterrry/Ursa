//
//  CarTitleView.swift
//  Constellation
//
//  Created by aydar.media on 22.07.2023.
//

import SwiftUI

struct CarTitleView: View {
    var content: String
    
    var body: some View {
        Text(content)
            .textStyle(size: 26)
    }
}

struct CarTitleView_Previews: PreviewProvider {
    static var previews: some View {
        CarTitleView(content: "My car")
    }
}
