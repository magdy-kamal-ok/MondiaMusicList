//
//  MusicModel.swift
//  MondiaMusicList
//
//  Created by mac on 7/8/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation

struct Music {
    var id: Int?
    var type: String?
    var title: String?
    var publishingDate: String?
    var label: String?
    var duration: Int?
    var numberOfTracks: Int?
    var artist: Artist?
    var coverImage: CoverImage?
    var statistics: Statistics?

}

extension Music: Decodable {

    enum MusicCodingKeys: String, CodingKey {
        case id = "id"
        case type = "type"
        case title = "title"
        case publishingDate = "publishingDate"
        case artist = "mainArtist"
        case cover = "cover"
        case duration = "duration"
        case numberOfTracks = "numberOfTracks"
        case label = "label"
        case statistics = "statistics"

    }


    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: MusicCodingKeys.self)

        id = try? values.decode(Int.self, forKey: .id)
        type = try? values.decode(String.self, forKey: .type)
        title = try? values.decode(String.self, forKey: .title)
        publishingDate = try? values.decode(String.self, forKey: .publishingDate)
        label = try? values.decode(String.self, forKey: .label)

        duration = try? values.decode(Int.self, forKey: .duration)
        numberOfTracks = try? values.decode(Int.self, forKey: .numberOfTracks)

        artist = try? values.decode(Artist.self, forKey: .artist)
        coverImage = try? values.decode(CoverImage.self, forKey: .cover)
        statistics = try? values.decode(Statistics.self, forKey: .cover)
    }
}
