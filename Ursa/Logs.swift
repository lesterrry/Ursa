//
//  Logs.swift
//  Ursa
//
//  Created by aydar.media on 01.08.2023.
//

import Foundation

public struct Logs {
    private static func logFilePath() -> URL? {
        let fileManager = FileManager.default
        guard let downloadsDirectory = fileManager.urls(for: .downloadsDirectory, in: .userDomainMask).first else {
            return nil
        }
        let logFileName = "YourAppName.log"
        return downloadsDirectory.appendingPathComponent(logFileName)
    }
    
    public static func write(_ message: String) {
        guard let logURL = self.logFilePath() else {
            print("Error getting log file path."); return
        }
        
        let timestamp = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = dateFormatter.string(from: timestamp)
        
        let logMessage = "\(formattedDate): \(message)\n"
        
        if let data = logMessage.data(using: .utf8) {
            if FileManager.default.fileExists(atPath: logURL.path) {
                do {
                    let fileHandle = try FileHandle(forWritingTo: logURL)
                    fileHandle.seekToEndOfFile()
                    fileHandle.write(data)
                    fileHandle.closeFile()
                } catch {
                    print("Error writing to log: \(error)")
                }
            } else {
                // If the file doesn't exist, create it and write for the first time
                do {
                    try logMessage.write(to: logURL, atomically: true, encoding: .utf8)
                } catch {
                    print("Error creating log file: \(error)")
                }
            }
        }
    }

}
