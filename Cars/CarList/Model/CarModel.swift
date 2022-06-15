//
//  CarModel.swift
//  Cars
//
//  Created by Avaneesh on 04/04/22.
//

import Foundation

struct CarModel : Codable {
    
    let getCarSDetails: [Car]?
    
    enum CodingKeys: String, CodingKey {
        case getCarSDetails = "content"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        getCarSDetails = try values.decodeIfPresent([Car].self, forKey: .getCarSDetails)
    }
    
}
