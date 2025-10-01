//
//  DateFormatter+Extensions.swift
//  BeReallyReal
//
//  Created by Trust-Worthy on 10/1/25.
//

import Foundation

extension DateFormatter {
    static var postFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
}
