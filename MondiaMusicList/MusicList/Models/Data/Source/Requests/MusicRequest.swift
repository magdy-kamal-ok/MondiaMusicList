//
//  MusicRequest.swift
//  MondiaMusicList
//
//  Created by mac on 7/8/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation

protocol MusicRequestDelegate: NSObjectProtocol {
    
    func requestWillSend()
    
    func requestSucceeded(data: [Music]?)
    
    func requestFailed(error: ErrorModel?)
}

class MusicRequest: BaseMusicRequest<Music, ErrorModel> {
    
    weak var delegate: MusicRequestDelegate?
    
    public override init() {
        super.init()
    }
    
    public func getMusicData(searchBy:String){
        delegate?.requestWillSend()
        let apiUrl = Constants.apiUrl + searchBy
        getMusicRequsetData(from: apiUrl)
    }
    
    override func onRequestSuccess(data: [Music]?) {
        delegate?.requestSucceeded(data: data)
    }
    override func onRequestFail(error: ErrorModel?) {
        delegate?.requestFailed(error: error)
    }

    
}
