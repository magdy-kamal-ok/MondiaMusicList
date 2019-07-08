//
//  Artist.swift
//  MondiaMusicList
//
//  Created by mac on 7/8/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation

struct Artist {
    var id: Int? = 0
    var name: String? = ""
}

extension Artist: Decodable {
    
    private enum ArtistCodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: ArtistCodingKeys.self)
        
        id = try? values.decode(Int.self, forKey: .id)
        name = try? values.decode(String.self, forKey: .name)
        
    }
}



