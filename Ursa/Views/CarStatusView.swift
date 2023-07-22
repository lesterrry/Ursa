//
//  CarStatusView.swift
//  Ursa
//
//  Created by aydar.media on 22.07.2023.
//

import SwiftUI

struct CarStatusView: View {
    enum CarStatus {
        case armed
        case disarmed
    }
    
    var status: CarStatus
    
    var title: String {
        switch status {
        case .armed:
            return "в охране"
        case .disarmed:
            return "снято"
        }
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Text(title)
                .textStyle(size: 12, weight: .semibold)
        }
        .padding(.horizontal, 12)
        .padding(.top, 1.2)
        .padding(.bottom, 2.4)
        .background(Color(red: 0.81, green: 0.14, blue: 0.14))
        .cornerRadius(87)
    }
}

struct CarStatusView_Previews: PreviewProvider {
    static var previews: some View {
        CarStatusView(status: .armed)
    }
}
