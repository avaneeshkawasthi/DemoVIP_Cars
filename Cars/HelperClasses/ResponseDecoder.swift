//
//  ResponseDecoder.swift
//  Cars
//
//  Created by Avaneesh on 04/04/22.
//

import Foundation

public class JSONResponseCoder {
    class func handleSuccessResponse<T: Codable>(data: Data, completion: (Result<T, APIError>) -> ()) {
        do {
            let model = try JSONDecoder().decode(T.self, from: data)
            completion(.success(model))
        }catch {
            completion(.failure(.parsingError))
        }
    }
    
    class func toJsonSerializer<T: Codable>(type: T.Type, from data: Data?) throws -> Codable {
        guard let data = data else {
            throw APIError.noData
        }
        do {
            let codable = try JSONDecoder().decode(T.self, from: data)
            return codable
        }catch {
            throw APIError.parsingError
        }
    }
}
