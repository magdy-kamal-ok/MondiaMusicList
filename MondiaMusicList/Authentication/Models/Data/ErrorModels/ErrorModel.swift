//
//  ErrorModel.swift
//  MondiaMusicList
//
//  Created by mac on 7/8/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation

public typealias Codable = Decodable & Encodable

struct ErrorModel : Codable{
    var code: String
    var error : String
    var message: String
    
    
    init(code: String, error:String , message: String) {
        self.code = code
        self.error = error
        self.message = message
    }
}

extension ErrorModel {
    
    enum ErrorCodingKeys: String, CodingKey {
        case statusCode = "status"
        case errorType = "error"
        case statusMessage = "description"

    }
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: ErrorCodingKeys.self)
        
        code = try values.decode(String.self, forKey: .statusCode)
        error = try values.decode(String.self, forKey: .errorType)
        message = try values.decode(String.self, forKey: .statusMessage)
    }
}
