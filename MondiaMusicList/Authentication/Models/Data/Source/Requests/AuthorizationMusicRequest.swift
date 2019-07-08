//
//  AuthorizationMusicRequest.swift
//  MondiaMusicList
//
//  Created by mac on 7/8/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation

protocol AuthorizationMusicRequestDelegate: NSObjectProtocol {
    
    func requestWillSend()
    
    func requestSucceeded(data: AuthorizationToken?)
    
    func requestFailed(error: ErrorModel?)
}

class AuthorizationMusicRequest: BaseAuthorizationMusicRequest<AuthorizationToken, ErrorModel> {
    
    weak var delegate: AuthorizationMusicRequestDelegate?
    
    public override init() {
        super.init()
    }
    
    deinit {
        print("a")
    }
    public func getAuthorizationToken(){
        delegate?.requestWillSend()
        let apiUrl = Constants.apiTokenUrl
        getAuthorizationMusicToken(from: apiUrl)
    }
    
    override func onRequestSuccess(data: AuthorizationToken?) {
        delegate?.requestSucceeded(data: data)
    }
    override func onRequestFail(error: ErrorModel?) {
        delegate?.requestFailed(error: error)
    }

    
}
