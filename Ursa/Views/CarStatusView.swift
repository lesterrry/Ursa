//
//  CarStatusView.swift
//  Ursa
//
//  Created by aydar.media on 22.07.2023.
//

import SwiftUI

struct CarStatusView: View {
    var status: CarData.State
    
    var title: String {
        switch status {
        case .armed:
            return "в охране"
        case .disarmed:
            return "снято"
        case .running:
            return "запуск"
        case .alarm:
            return "тревога"
        case .service:
            return "сервис"
        case .stayHome:
            return "stay-home"
        case .unknown:
            return "неизв"
        }
    }
    var backgroundColor: Color {
        switch status {
        case .armed, .stayHome:
            return Color(red: 0.31, green: 1, blue: 0.2)
        case .disarmed:
            return Color(.white)
        case .running:
            return (Color(red: 1, green: 0.58, blue: 0.2))
        case .alarm:
            return Color(red: 0.81, green: 0.14, blue: 0.14)
        case .service:
            return Color(red: 1, green: 0.87, blue: 0.2)
        case .unknown:
            return Color(red: 0.24, green: 0.24, blue: 0.24)
        }
    }
    var foregroundColor: Color {
        switch status {
        case .armed, .disarmed, .stayHome, .service, .running:
            return Color(.black)
        case .alarm, .unknown:
            return Color(.white)
        }
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Text(title)
                .foregroundColor(self.foregroundColor)
                .textStyle(size: 12, weight: .semibold)
        }
        .padding(.horizontal, 12)
        .padding(.top, 1.2)
        .padding(.bottom, 2.4)
        .background(self.backgroundColor)
        .cornerRadius(87)
    }
}

struct CarStatusView_Previews: PreviewProvider {
    static var previews: some View {
        CarStatusView(status: .unknown)
    }
}
