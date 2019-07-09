//
//  AuthorizationViewModel.swift
//  MondiaMusicList
//
//  Created by mac on 7/8/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import UIKit

protocol AuthorizationViewModelDelegate: class {
    func showLoader()

    func finishRequestingAccessToken()

    func authorizeFailed(error: ErrorModel?)

}
class AuthorizationViewModel: NSObject {

    //
    //MARK: Parameters
    //
    private var backendManager = AuthorizationMusicBackendManager()
    weak var authorizationViewModelDelegate: AuthorizationViewModelDelegate?

    //
    // MARK: Initializer
    //
    override init() {
        super.init()
    }
    convenience init(delegate: AuthorizationViewModelDelegate) {
        self.init()
        self.authorizationViewModelDelegate = delegate
    }

    //
    //MARK: Network Request
    //
    public func getAuthorizationMusicToken() {

        backendManager.getAuthorizationMusicToken(delegate: self)
    }
    //
    // MARK: Cancel Network Request
    //


    func checkTokenValidation() -> Bool
    {
        if let auth = UserDefaultsHelper.getAuthorizeToken(key: Constants.authorizeResponseKey), let timeInterval = UserDefaultsHelper.getStringFromUserDefaults(key: Constants.timeofAuthorizationKey)

        {
            let expireAuth = Double(auth.expiresIn!)!

            let savedTimeInterval = Double(timeInterval)!
            let currnetTimeInterval = Date.timeIntervalSinceReferenceDate


            if currnetTimeInterval - savedTimeInterval < (expireAuth - 100)
            {
                return true
            }
            else
            {
                return false
            }
        }
        return false
    }

    // check if the cached auth key is still valid if not the authviewmodel
    // will perform call to the server asking foe new one
    func checkAuthorization()
    {

        if self.checkTokenValidation()
        {
            self.authorizationViewModelDelegate?.finishRequestingAccessToken()
        }
        else
        {
            getAuthorizationMusicToken()
        }
    }


    func cancelMusicDatatRequest() {
        backendManager.cancelMusicDatatRequest()
    }

}
// MARK: Authorization request delegate

extension AuthorizationViewModel: AuthorizationMusicRequestDelegate
{

    func requestWillSend() {
        self.authorizationViewModelDelegate?.showLoader()
    }

    func requestSucceeded(data: AuthorizationToken?) {
        if let auth = data
        {
            UserDefaultsHelper.setAuthorizeToken(key: Constants.authorizeResponseKey, value: auth)

            let timeInterval = String(Date.timeIntervalSinceReferenceDate)
            UserDefaultsHelper.saveStringData(value: timeInterval, key: Constants.timeofAuthorizationKey)
            self.authorizationViewModelDelegate?.finishRequestingAccessToken()


        }
    }

    func requestFailed(error: ErrorModel?) {
        self.authorizationViewModelDelegate?.authorizeFailed(error: error)
    }

}
