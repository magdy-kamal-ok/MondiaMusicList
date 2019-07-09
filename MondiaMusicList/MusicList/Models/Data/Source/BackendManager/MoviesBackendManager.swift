//
//  MusicBackendManager.swift
//  MondiaMusicList
//
//  Created by mac on 7/8/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import UIKit

class MusicBackendManager: NSObject {


    lazy var musicRequest = MusicRequest()

    public func getMusic(delegate: MusicRequestDelegate, searchBy: String) {
        musicRequest.delegate = delegate
        musicRequest.getMusicData(searchBy: searchBy)
    }
    func cancelMusicDatatRequest() {
        musicRequest.cancelRequest()
    }
}

