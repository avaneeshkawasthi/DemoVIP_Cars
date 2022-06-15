//
//  CarsApiWorker.swift
//  Cars
//
//  Created by Avaneesh on 04/04/22.
//

import Foundation

class GetCarsAPIWorker : NetworkTaskProtocol {
    
    lazy var sessionHelper: URLSessionHelper = { URLSessionHelper() }()
    
    func getCarList(completion: @escaping (Result<CarModel, APIError>) -> ()) {
        
        let urlStr = "\(URLConstant.apiBaseURL.rawValue)/article/get_articles_list"
                
        guard let url = URL(string: urlStr) else {
            completion(.failure(.invalidRequest))
            return
        }

        sessionHelper.makeRequest(url: url) { (result) in
            switch result {
            case .success(let data):
                JSONResponseCoder.handleSuccessResponse(data: data, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func dictionaryToJson(dictionary: [String: Any]) -> Data? {
        do {
            let checker = JSONSerialization.isValidJSONObject(dictionary)
            if checker {
                let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: [.prettyPrinted])
                if let string = String(data: jsonData, encoding: String.Encoding.utf8) {
                       print(string)
                 }
                return jsonData
            }
            else {
                return nil
            }
        } catch {
            return nil
        }
    }
    
}
