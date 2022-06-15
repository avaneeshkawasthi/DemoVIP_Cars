//
//  Car.swift
//  Cars
//
//  Created by Avaneesh on 04/04/22.
//

import Foundation

struct Car : Codable {
    
    var id : Int?
    var title : String?
    var ingress : String?
    var image : String?
    var dateTime : String?
    var tags : [String]?
    var content : [carItems]?
    var created : Int?
    var changed : Int?
   
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case title = "title"
        case ingress = "ingress"
        case image = "image"
        case dateTime = "dateTime"
        case tags = "tags"
        case content = "content"
        case created = "created"
        case changed = "changed"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        ingress = try values.decodeIfPresent(String.self, forKey: .ingress)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        dateTime = try values.decodeIfPresent(String.self, forKey: .dateTime)
        tags = try values.decodeIfPresent([String].self, forKey: .tags)
        content = try values.decodeIfPresent([carItems].self, forKey: .content)
        created = try values.decodeIfPresent(Int.self, forKey: .created)
        changed = try values.decodeIfPresent(Int.self, forKey: .changed)
    }
    
    
}


struct carItems : Codable {
    
    var type : String?
    var Subject : String?
    var Description : String?
    
    enum CodingKeys: String, CodingKey {
        
        case type = "type"
        case Subject = "subject"
        case Description = "description"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        Subject = try values.decodeIfPresent(String.self, forKey: .Subject)
        Description = try values.decodeIfPresent(String.self, forKey: .Description)
    }
    
    
}


