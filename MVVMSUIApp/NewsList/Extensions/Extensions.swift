//
//  Extensions.swift
//  MVVMSUIApp
//
//  Created by Hilal İnan on 22.07.2025.
//

import Foundation

extension Int {
    func timeAgoDisplay() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: date, relativeTo: Date())
    }
}

extension URL {
    func hostName() -> String {
        self.host ?? self.absoluteString
    }
}
