//
//  Book.swift
//  GoogleBookSearch
//
//  Created by Brendon Crowe on 1/12/23.
//

import Foundation

struct Books: Decodable {
    let items: [Book]
}
struct Book: Decodable {
    struct Volume: Decodable {
        let title: String
        let subtitle: String?
        let authors: [String]?
        let description: String?
        let imageLinks: ImageLink?
    }
    struct ImageLink: Decodable {
        let smallThumbnail: String
        let thumbnail: String
    }
    let volumeInfo: Volume
}

extension Books {
    static func getBooks(from: Data) -> [Book] {
        var books = [Book]()
        let data = Bundle.readRawJSONData(filename: "Book", ext: "json")
        let decoder = JSONDecoder()
        do {
            let booksArray = try decoder.decode(Books.self, from: data)
            books = booksArray.items
        } catch {
            fatalError("Could not decode data: \(error)")
        }
        return books
    }
}
