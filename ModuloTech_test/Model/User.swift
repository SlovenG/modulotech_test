//
//  User.swift
//  ModuloTech_test
//
//  Created by Sloven Graciet on 29/03/2021.
//

import Foundation

struct User: Decodable {
    
    let firstName: String
    let lastName: String
    let address: Address
    let birthDate: Date
}

struct Address: Decodable {
    
    let city: String
    let postalCode: Int
    let street: String
    let streetCode: String
    let country: String
}

struct UserResponse: Decodable {
    
    let user: User
    
    enum UserKey: CodingKey {
        case user
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserKey.self)
        self.user = try container.decode(User.self, forKey: .user)
    }
}
