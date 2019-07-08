//
//  AuthorizationMusicBackendManager.swift
//  MondiaMusicList
//
//  Created by mac on 7/8/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import UIKit

class AuthorizationMusicBackendManager: NSObject {
    
    
    lazy var authorizationMusicRequest = AuthorizationMusicRequest()
    
    public func getAuthorizationMusicToken(delegate: AuthorizationMusicRequestDelegate) {
        authorizationMusicRequest.delegate = delegate
        authorizationMusicRequest.getAuthorizationToken()
    }
    func cancelMusicDatatRequest() {
        authorizationMusicRequest.cancelRequest()
    }
}

