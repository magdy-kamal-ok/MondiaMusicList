//
//  AuthorizationToken.swift
//  MondiaMusicList
//
//  Created by mac on 7/8/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation

struct AuthorizationToken:Codable {

    var accessToken: String?
    var tokenType: String?
    var expiresIn: String?

}

extension AuthorizationToken {
    enum AuthorizationTokenCodingKeys: String, CodingKey {
        case accessToken        = "accessToken"
        case tokenType          = "tokenType"
        case expiresIn          = "expiresIn"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: AuthorizationTokenCodingKeys.self)
        accessToken = try? values.decode(String.self, forKey: .accessToken)
        tokenType =  try? values.decode(String.self, forKey: .tokenType)
        expiresIn = try? values.decode(String.self, forKey: .expiresIn)
        
    }
}
