//
//  MusicModel.swift
//  MondiaMusicList
//
//  Created by mac on 7/8/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import UIKit

struct Music {
    var id: Int? = 0
    var type: String? = ""
    var title: String? = ""
    var publishingDate: String? = ""
    var artist:Artist?
    var coverImage:CoverImage?
    
    init(title: String, publishingDate: String)
    {
        self.title = title
        self.publishingDate = publishingDate
    }
}

extension Music: Decodable {
    
    enum MusicCodingKeys: String, CodingKey {
        case id         = "id"
        case type       = "type"
        case title      = "title"
        case publishingDate = "publishingDate"
        case artist = "mainArtist"
        case cover = "cover"

    }
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: MusicCodingKeys.self)
        
        id = try? values.decode(Int.self, forKey: .id)
        type = try? values.decode(String.self, forKey: .type)
        title =  try? values.decode(String.self, forKey: .title)
        publishingDate = try? values.decode(String.self, forKey: .publishingDate)
        artist = try? values.decode(Artist.self, forKey: .artist)
        coverImage = try? values.decode(CoverImage.self, forKey: .cover)
    }
}
