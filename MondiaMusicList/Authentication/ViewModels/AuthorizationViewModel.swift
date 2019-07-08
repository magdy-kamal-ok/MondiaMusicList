//
//  AuthorizationViewModel.swift
//  MondiaMusicList
//
//  Created by mac on 7/8/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import UIKit

class AuthorizationViewModel: NSObject {
    
    //
    //MARK: Parameters
    //
    private var backendManager = AuthorizationMusicBackendManager()
    //
    // MARK: Initializer
    //
    override init() {
        super.init()
    }
    
    convenience init(delegate:MusicViewControllerDelegate) {
        self.init()
//        self.musicViewControllerDelegate = delegate
    }

    //
    //MARK: Network Request
    //
    public func getAuthorizationMusicToken() {
        if Reachability.isConnectedToNetwork()
        {
            backendManager.getAuthorizationMusicToken(delegate: self)
        }
        else
        {
            self.showNoInternetConnection()
        }
    }
    //
    // MARK: Cancel Network Request
    //
    
    func cancelMusicDatatRequest() {
        backendManager.cancelMusicDatatRequest()
    }
    
   
    private func showAlertMessage(message:String)
    {
        let alert = UIAlertController(title: Constants.error.localized, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: Constants.retry.localized, style: UIAlertAction.Style.default, handler: { (action) in
            self.getAuthorizationMusicToken()
        }))
        alert.addAction(UIAlertAction(title: Constants.cancel.localized, style: UIAlertAction.Style.cancel, handler: { (action) in
            self.cancelMusicDatatRequest()
        }))
        
        //musicViewControllerDelegate?.showAlert(alert: alert)
    }
    
    private func showNoInternetConnection()
        
    {
        let alert = UIAlertController(title: Constants.warning.localized, message: Constants.INTERNET_CONNECTION.localized, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: Constants.ok.localized, style: UIAlertAction.Style.default, handler: { (action) in
            //self.stopAllLoaders()
        }))
        
        //musicViewControllerDelegate?.showAlert(alert: alert)
    }

    
}
// MARK: Music request delegate

extension AuthorizationViewModel:AuthorizationMusicRequestDelegate
{

    func requestWillSend() {
        
        
    }

    func requestSucceeded(data: AuthorizationToken?) {
        let defaults = UserDefaults.standard
        defaults.set(codable: data, forKey: "Test")
        
       let token = defaults.codable(AuthorizationToken.self, forKey: "Test")
        print(token)
        
    }

    func requestFailed(error:ErrorModel?) {
        
        
    }

}
