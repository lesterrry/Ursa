//
//  CarMetricView.swift
//  Constellation
//
//  Created by aydar.media on 22.07.2023.
//

import SwiftUI

struct CarMetricView: View {
    var value: String
    var description: String
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 6) {
            Text(value)
                .textStyle(size: 14, weight: .medium)
            Text(description)
                .foregroundColor(Color(red: 0.34, green: 0.34, blue: 0.34))
                .padding(.bottom, 1)
                .textStyle(size: 10, weight: .semibold)
        }
    }
}

struct CarMetricView_Previews: PreviewProvider {
    static var previews: some View {
        CarMetricView(value: "50%", description: "топлива")
    }
}
