//
//  CoverImage.swift
//  MondiaMusicList
//
//  Created by mac on 7/8/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation

struct CoverImage {
    var medium: String? = ""
}

extension CoverImage: Decodable {
    
    private enum CoverImageCodingKeys: String, CodingKey {
        case medium = "medium"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CoverImageCodingKeys.self)
        
        let imagePath  = try? values.decode(String.self, forKey: .medium)
        if imagePath != "" && !(imagePath?.contains("http:"))!
        {
            medium = "http:" + imagePath!
        }
        else
        {
            medium = ""
        }
        
    }
}



