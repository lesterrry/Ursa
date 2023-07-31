//
//  Widget.swift
//  Widget
//
//  Created by aydar.media on 22.07.2023.
//

import WidgetKit
import SwiftUI
import Foundation
import Constellation
import os.log

struct SimpleEntry: TimelineEntry {
    let date: Date
    let carImagePath: String? = nil
    var carData: CarData = CarData()
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        fetchCar() { data in
            completion(data)
        }
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        fetchCar() { data in
            entries.append(data)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    private func fetchCar(completion: @escaping (SimpleEntry) -> Void) {
        os_log("Starting request....")
        var entry = SimpleEntry(date: Date())
        guard
            let appId = try? Keychain.getToken(account: KeychainEntity.Account.appId.rawValue),
            let appSecret = try? Keychain.getToken(account: KeychainEntity.Account.appSecret.rawValue),
            let userLogin = try? Keychain.getToken(account: KeychainEntity.Account.userLogin.rawValue),
            let userPassword = try? Keychain.getToken(account: KeychainEntity.Account.userPassword.rawValue),
            let deviceId = try? Keychain.getToken(account: KeychainEntity.Account.deviceId.rawValue)
        else {
            entry.carData.alias = "No Keychain"
            completion(entry); return
        }
        
        let semaphore = DispatchSemaphore(value: 0)
        DispatchQueue.global().async {
            Task.init {
                var fetchedEntry = SimpleEntry(date: Date())
                
                var client = ApiClient(appId: appId, appSecret: appSecret, userLogin: userLogin, userPassword: userPassword)
                guard client.hasUserToken else {
                    fetchedEntry.carData.alias = "No User Token"
                    completion(fetchedEntry); return
                }
                
                await client.auth() { result in
                    if case .failure(_) = result {
                        fetchedEntry.carData.alias = "Failed auth"
                        completion(fetchedEntry); return
                    }
                }
                await client.getDeviceData(for: Int(deviceId)!) { result in
                    switch result {
                    case .failure(_):
                        fetchedEntry.carData.alias = "Failed request"
                        completion(fetchedEntry); return
                    case .success(let data):
                        if case ApiResponse.Data.device(let device) = data {
                            fetchedEntry.carData.alias = device.alias
                            fetchedEntry.carData.doorsOpen = device.state?.door
                            fetchedEntry.carData.hoodOpen = device.state?.hood
                            fetchedEntry.carData.trunkOpen = device.state?.trunk
                            fetchedEntry.carData.gpsLevel = device.common?.gpsLevel
                            fetchedEntry.carData.gsmLevel = device.common?.gsmLevel
                            fetchedEntry.carData.ignitionPowered = device.state?.ignition
                            fetchedEntry.carData.remainingDistance = device.obd?.remainingDistance
                            fetchedEntry.carData.batteryVoltage = device.common?.battery
                            fetchedEntry.carData.parkingBrakeEngaged = device.state?.parkingBrake
                            fetchedEntry.carData.isArmed = device.state?.arm
                            fetchedEntry.carData.alarmTriggered = device.state?.alarm
                            fetchedEntry.carData.valetModeOn = device.state?.valet
                            fetchedEntry.carData.stayHomeModeOn = device.state?.stayHome
                            completion(fetchedEntry); return
                        } else {
                            fetchedEntry.carData.alias = "Erroneous data"
                            completion(fetchedEntry); return
                        }
                    }
                }
                semaphore.signal()
            }
        }
    }
}

struct WidgetEntryView: View {
    var entry: Provider.Entry
    
    var carImage: NSImage {
        if let path = entry.carImagePath, let image = NSImage(contentsOfFile: path) {
            return image
        } else {
            return NSImage(named: NSImage.Name("DefaultCar"))!
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {  // Top-level column
            HStack {  // Horizontal flexbox with title & status
                CarTitleView(content: entry.carData.alias ?? "Неизвестно")
                Spacer()
                CarStatusView(status: .armed)
            }
            .hstackStyle()
            CarMetricView(value: String(entry.carData.remainingDistance ?? 0), description: "км в баке")
                .padding(.top, -20)
                .offset(y: 20)
            Spacer()
            HStack(alignment: .bottom) {  // Car image and detailed stats
                CarImageView(image: carImage)
                Spacer()
                let metrics: [[String]] = [
                    [String(entry.carData.batteryVoltage ?? 0), "вольт"],
                    [entry.carData.$ignitionPowered, "зажигание"],
                    [entry.carData.perimeter(), "периметр"],
                    [entry.carData.gsmLevelDescription(), "gsm связь"],
                    [entry.carData.$parkingBrakeEngaged, "ручник"],
                ]
                VStack(alignment: .trailing, spacing: 2) {
                    ForEach(metrics, id: \.self) { i in
                        CarMetricView(value: i[0], description: i[1])
                    }
                }
            }
            .hstackStyle()
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
        .padding(.bottom, 12)
        .environment(\.colorScheme, .dark)
    }
}

@main
struct DefaultWidget: Widget {
    let kind: String = "DefaultWidget"
    var supportedFamilies: [WidgetFamily] {
#if DEBUG
        [WidgetFamily.systemSmall, WidgetFamily.systemMedium, WidgetFamily.systemLarge]
#else
        [WidgetFamily.systemSmall]
#endif
    }
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetEntryView(entry: entry)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: Color(red: 0.1, green: 0.1, blue: 0.1), location: 0.10),
                            Gradient.Stop(color: Color(red: 0.05, green: 0.05, blue: 0.05), location: 0.85),
                        ],
                        startPoint: UnitPoint(x: 0.5, y: 0),
                        endPoint: UnitPoint(x: 0.5, y: 1)
                    )
                )
        }
        .supportedFamilies(supportedFamilies)
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct DefaultWidget_Previews: PreviewProvider {
    static var previews: some View {
        WidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
