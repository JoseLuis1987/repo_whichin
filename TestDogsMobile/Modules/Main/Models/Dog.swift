//
//  Dog.swift
//  TestDogsMobile
//
//  Created by Jose Luis on 16/03/22.
//

import Foundation
// MARK: - DogData
typealias Codable = Decodable & Encodable
struct Dog: Codable {

    var id, dogName, strDescription,dogImage: String?
    var age: Int?
    init() {}
    internal init(id: String, dogName: String, strDescription: String, age: Int, dogImage: String) {
        self.id = id
        self.dogName = dogName
        self.strDescription = strDescription
        self.age = age
        self.dogImage = dogImage
    }
    public init(from decoder: Decoder) throws {
       let container  = try decoder.container(keyedBy: CodingKeys.self)
       dogName        = try (container.decodeIfPresent(String.self, forKey: .dogName)) ?? ""
       strDescription = try (container.decodeIfPresent(String.self, forKey: .strDescription))  ?? ""
       age            = try (container.decodeIfPresent(Int.self, forKey: .age)) ?? 0
       dogImage       = try (container.decodeIfPresent(String.self, forKey: .dogImage)) ?? ""
   }
    enum CodingKeys: String, CodingKey {
        case id
        case dogName = "dogName"
        case strDescription = "description"
        case age = "age"
        case dogImage = "image"
    }
}
