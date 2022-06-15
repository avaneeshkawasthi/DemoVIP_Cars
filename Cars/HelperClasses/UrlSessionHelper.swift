//
//  UrlSessionHelper.swift
//  Cars
//
//  Created by Avaneesh on 04/04/22.
//

import Foundation

protocol  URLSessionProtocol: AnyObject {
    func makeRequest(url: URL, completion: @escaping (Result<Data, APIError>) -> Void)
    func makePostRequest(urlRequest: URLRequest, completion: @escaping (Result<Data, APIError>) -> Void)
}

enum APIError: Error {
    case invalidRequest
    case invalidResponse
    case parsingError
    case noData
    case noConnection
    case unknown
}


enum errorResponse: String {
    case firebseError
    case noData
    case noConnection
    case unknown
}


class URLSessionHelper: URLSessionProtocol {
    
    private let urlSession: URLSession
    private let statusOK = 200
    private let statusInternalServerError = 500
    private let statusNotFound = 404
    
    typealias SessionResponse = ((Result<Data, APIError>) -> Void)
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
        self.urlSession.configuration.timeoutIntervalForRequest = 30.0
        self.urlSession.configuration.timeoutIntervalForResource = 60.0
    }
    
    func isSuccess(_ code: Int) -> Bool {
        return code == statusOK
    }
    
    func makeRequest(url: URL, completion: @escaping SessionResponse) {
        self.runSessionTask(url: url, completion: completion)
    }

    func makePostRequest(urlRequest: URLRequest, completion: @escaping SessionResponse) {
        self.runSessionTaskWithURLRequest(urlRequest: urlRequest, completion: completion)
    }
    
    private func runSessionTask(url: URL, completion: @escaping SessionResponse) {
        let task = urlSession.dataTask(with: url) { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                guard let self = self else {
                    completion(.failure(.unknown))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                if error == nil, self.isSuccess(httpResponse.statusCode) {
                    guard let data = data else {
                        completion(.failure(.noData))
                        return
                    }
                    
                    completion(.success(data))
                    
                }else {
                    let apiError = error as? APIError ?? APIError.unknown
                    completion(.failure(apiError))
                }
            }
        }
        task.resume()
    }
    
    private func runSessionTaskWithURLRequest(urlRequest: URLRequest, completion: @escaping SessionResponse) {
        let task = urlSession.dataTask(with: urlRequest, completionHandler: { [weak self](data, response , error) in
            DispatchQueue.main.async {
                guard let self = self else {
                    completion(.failure(.unknown))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                if error == nil, self.isSuccess(httpResponse.statusCode) {
                    guard let data = data else {
                        completion(.failure(.noData))
                        return
                    }
                    
                    completion(.success(data))
                    
                }else {
                    let apiError = error as? APIError ?? APIError.unknown
                    completion(.failure(apiError))
                }
            }
        })
        task.resume()
    }
}
