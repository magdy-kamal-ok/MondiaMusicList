//
//  MusicListViewController.swift
//  MondiaMusicList
//
//  Created by mac on 7/8/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import UIKit

class MusicListViewController: BaseMusicListViewController {
    // MARK: Parameters
    var musicViewModel:MusicViewModel?
    // MARK: ViewController lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        musicViewModel = MusicViewModel.init(delegate: self)
        self.musicSearchBar.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.MusicTableView.reloadData()
        self.title = Constants.Music_LIST_TITLE.localized
    }
    // MARK: override required methods needed from parent class
    override func setupCellNibName() {
        self.cellNibName = "MusicTableViewCell"
    }
    
    override func getCellHeight() -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func getCellsCount(with section:Int) -> Int {
        
        return musicViewModel?.allMusicArray.count ?? 0
    }
    
    override func getSectionsCount() -> Int {
        return self.musicViewModel?.getSectionsCount() ?? 0
    }
    
    
    override func getCustomCell(_ tableView: UITableView, customCell: UITableViewCell, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let musicTableViewCell = customCell as! MusicTableViewCell
        var music:Music?
        music = self.musicViewModel?.allMusicArray[indexPath.row] as? Music
        musicTableViewCell.configureCell(music: music!)
       
        return musicTableViewCell
    }
    
    override func didSelectCellAt(indexPath: IndexPath) {
        let musicDetailsViewController = MusicDetailsViewController.init(nibName: "MusicDetailsViewController", bundle: nil) 
        let musicModel = self.musicViewModel?.allMusicArray[indexPath.row] as! Music
        musicDetailsViewController.musicModel = musicModel
        self.navigationController?.pushViewController(musicDetailsViewController, animated: true)
        
    }

}
extension MusicListViewController:MusicViewControllerDelegate
{
    func showAlert(alert: UIAlertController) {
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func showLoader(flag: Bool) {
        if flag
        {
            self.showProgressLoaderIndicator()
        }
        else
        {
            self.hideProgressLoaderIndicator()
        }
    }
    
    func reloadMusicData() {
        //
        DispatchQueue.main.async {
          self.MusicTableView.reloadData()
        }
        
    }
    
    
    
}
extension MusicListViewController:UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.musicSearchBar.becomeFirstResponder()
        self.musicSearchBar.showsCancelButton = true
        self.musicViewModel?.searchText = searchBar.text!
        self.musicViewModel?.getMusicData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.musicSearchBar.showsCancelButton = false
        self.musicSearchBar.resignFirstResponder()
    }
    
    
}
