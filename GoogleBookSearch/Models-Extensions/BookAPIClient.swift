//
//  BookAPIClient.swift
//  GoogleBookSearch
//
//  Created by Brendon Crowe on 1/12/23.
//

import Foundation


// MARK: The purpose of this client is to get the search query data

struct BookAPIClient {
    static func getBooks(from api: String, completion: @escaping (Result<[Book], NetworkError>) -> ()) {
        NetWorkHelper.shared.performDataTask(with: api) { (result) in
            switch result {
            case .failure(let error):
                completion(.failure(.networkClientError(error)))
            case .success(let data):
                do {
                    let booksFromSearch = try JSONDecoder().decode(Books.self, from: data)
                    let books = booksFromSearch.items
                    completion(.success(books))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
