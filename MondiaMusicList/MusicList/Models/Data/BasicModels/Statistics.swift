//
//  Statistics.swift
//  MondiaMusicList
//
//  Created by mac on 7/8/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation

struct Statistics {
    var popularity: String? = ""
}

extension Statistics: Decodable {
    
    private enum StatisticsCodingKeys: String, CodingKey {
        case popularity = "popularity"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: StatisticsCodingKeys.self)
        
         popularity  = try? values.decode(String.self, forKey: .popularity)

    }
}



