//
//  NetworkHelper.swift
//  GoogleBookSearch
//
//  Created by Brendon Crowe on 1/12/23.
//

import Foundation



enum NetworkError: Error {
    case badURL(String)
    case networkClientError(Error)
    case noResponse
    case noData
    case badStatusCode(Int)
    case decodingError(Error)
    case noImage
}


class NetWorkHelper {
    static let shared = NetWorkHelper()
    private var session: URLSession
    private init() {
        session = URLSession(configuration: .default)
    }
    
    func performDataTask(with urlString: String,
                         completionHandler: @escaping (Result<Data, NetworkError>) -> ()) {
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.badURL(urlString)))
            return
        }
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completionHandler(.failure(.networkClientError(error)))
            }
            guard let urlResponse = response as? HTTPURLResponse else {
                completionHandler(.failure(.noResponse))
                return
            }
            switch urlResponse.statusCode {
            case 200...299: break
            default:
                completionHandler(.failure(.badStatusCode(urlResponse.statusCode)))
                return
            }
                guard let data = data else {
                    completionHandler(.failure(.noData))
                    return
                }
                completionHandler(.success(data))
            }
        dataTask.resume()
        }
    }
