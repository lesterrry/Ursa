//
//  Widget.swift
//  Widget
//
//  Created by aydar.media on 22.07.2023.
//

import WidgetKit
import SwiftUI
import Foundation

struct SimpleEntry: TimelineEntry {
    let date: Date
    let carImagePath: String? = nil
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct WidgetEntryView : View {
    var entry: Provider.Entry
    
    var carImageSource: NSImage {
        if let path = entry.carImagePath, let image = NSImage(contentsOfFile: path) {
            return image
        } else {
            return NSImage(named: NSImage.Name("DefaultCar"))!
        }
    }
    
    var body: some View {
        HStack {
            Image(nsImage: carImageSource)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100, alignment: .center)
            
            Text("AAA")
                .font(.largeTitle)
                .padding()
        }
        .padding()
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
                .background(Color("WidgetBackground"))
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
