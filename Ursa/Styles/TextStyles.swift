//
//  TextStyles.swift
//  Ursa
//
//  Created by aydar.media on 22.07.2023.
//

import Foundation
import SwiftUI

fileprivate struct TextStyle: ViewModifier {
    var fontSize: Int
    var fontWeight: Font.Weight
    
    func body(content: Content) -> some View {
        content
            .font(Font.custom("SF Mono", size: CGFloat(fontSize)).weight(fontWeight))
            .foregroundColor(.white)
    }
}

extension View {
    func textStyle(size: Int = 18, weight: Font.Weight = .regular) -> some View {
        self.modifier(TextStyle(fontSize: size, fontWeight: weight))
    }
}

