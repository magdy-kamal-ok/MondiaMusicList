//
//  MusicViewModel.swift
//  MondiaMusicList
//
//  Created by mac on 7/8/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//
import Foundation
import UIKit

protocol MusicViewControllerDelegate: NSObjectProtocol {
    
    func showLoader(flag:Bool)
    func reloadMusicData()
    func showAlert(alert:UIAlertController)
}
class MusicViewModel: NSObject {
    
    //
    //MARK: Parameters
    //
    lazy private var backendManager = MusicBackendManager()
    public private(set) var allMusicArray: NSMutableArray = []
    weak var musicViewControllerDelegate:MusicViewControllerDelegate?
    var searchText:String = ""
    
    //
    // MARK: Initializer
    //
    override init() {
        super.init()
    }
    convenience init(delegate:MusicViewControllerDelegate) {
        self.init()
        self.musicViewControllerDelegate = delegate
    }
    
    //
    //MARK: Network Request
    //
    public func getMusicData() {
        if Reachability.isConnectedToNetwork()
        {
            if !self.searchText.isEmpty
            {
                backendManager.getMusic(delegate: self, searchBy: self.searchText)
            }
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
    
    public func getSectionsCount()->Int
    {
        return 1
    }
    

    private func reloadDataSource()
    {
        musicViewControllerDelegate?.reloadMusicData()
    }
    
    private func showAlertMessage(message:String)
    {
        let alert = UIAlertController(title: Constants.error.localized, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: Constants.retry.localized, style: UIAlertAction.Style.default, handler: { (action) in
            self.getMusicData()
        }))
        alert.addAction(UIAlertAction(title: Constants.cancel.localized, style: UIAlertAction.Style.cancel, handler: { (action) in
            self.cancelMusicDatatRequest()
        }))
        
        musicViewControllerDelegate?.showAlert(alert: alert)
    }
    
    private func showNoInternetConnection()
    
    {
        let alert = UIAlertController(title: Constants.warning.localized, message: Constants.INTERNET_CONNECTION.localized, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: Constants.ok.localized, style: UIAlertAction.Style.default, handler: { (action) in
                self.stopAllLoaders()
        }))
        
        musicViewControllerDelegate?.showAlert(alert: alert)
    }
    
    private func stopAllLoaders()
    {
        musicViewControllerDelegate?.showLoader(flag: false)

    }
    
}
// MARK: Music request delegate

extension MusicViewModel:MusicRequestDelegate
{

    
    
    func requestWillSend() {
        
        musicViewControllerDelegate?.showLoader(flag: true)
       
    }
    
    func requestSucceeded(data: [Music]?) {
        musicViewControllerDelegate?.showLoader(flag: false)
        
        self.allMusicArray.removeAllObjects()
        
        if let musicResponse = data
        {
            self.allMusicArray.addObjects(from: musicResponse)
        }
        reloadDataSource()
    }
    
    func requestFailed(error:ErrorModel?) {

        musicViewControllerDelegate?.showLoader(flag: false)
        showAlertMessage(message: (error?.message)!)
    
    }
    
}
