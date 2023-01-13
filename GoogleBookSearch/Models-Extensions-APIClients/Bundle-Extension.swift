//
//  Bundle-Extension.swift
//  GoogleBookSearch
//
//  Created by Brendon Crowe on 1/12/23.
//

import Foundation


// MARK: For local JSON decoding ONLY

extension Bundle {
    static func readRawJSONData(filename: String, ext: String) -> Data {
        guard let fileUrl = Bundle.main.url(forResource: filename, withExtension: ext) else {
            fatalError("could not locate URL")
        }
        var data: Data!
        do {
            data = try Data.init(contentsOf: fileUrl)
        } catch {
            fatalError("Error: \(error)")
        }
        return data
    }
}
