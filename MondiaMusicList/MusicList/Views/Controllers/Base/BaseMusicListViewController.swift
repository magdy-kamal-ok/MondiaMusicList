//
//  BaseMusicListViewController.swift
//  MondiaMusicList
//
//  Created by mac on 7/8/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import UIKit

class BaseMusicListViewController: UIViewController {


    // MARK: - Outlets
    @IBOutlet weak var musicSearchBar: UISearchBar!
    @IBOutlet weak var MusicTableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    // MARK: - Variables

    var cellNibName: String?
    var cellNib: UINib?

    // MARK: - Base Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableDataSource()
        setupCellNibName()
        setupCellNibRegistration()
        setAccessiblityIdentifiers()
        hideProgressLoaderIndicator()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    private func setAccessiblityIdentifiers()
    {
        self.MusicTableView.accessibilityIdentifier = Constants.tableViewIdentifier
        self.musicSearchBar.accessibilityIdentifier = Constants.searchBarIdentifier
        self.loadingIndicator.accessibilityIdentifier = Constants.loadingIndicatorIdentifier

    }


    // MARK: - Table view

    func setupTableDataSource() -> Void {
        self.MusicTableView.delegate = self
        self.MusicTableView.dataSource = self
    }


    // MARK: Table view nib name

    public func setupCellNibName() -> Void {
        // This methode will overridw at sub classes
    }


    // MARK: Table view nib registeration

    func setupCellNibRegistration() -> Void {
        assert((self.cellNibName != nil) && !(self.cellNibName?.isEmpty)!, "Cell nib name, Override setupCellNibName Func")
        self.MusicTableView.register(getCellNIB(), forCellReuseIdentifier: self.cellNibName!)

    }

    public func getCellNIB() -> UINib {
        if(self.cellNib == nil) {
            assert((self.cellNibName != nil) && !(self.cellNibName?.isEmpty)!, "Cell nib name not set in controller")
            self.cellNib = UINib.init(nibName: self.cellNibName!, bundle: nil)
        }
        return self.cellNib!
    }


    func getCellHeight() -> CGFloat {
        preconditionFailure("You have to Override getCellHeight Function first to be able to set cell height")
    }

    func getCellsCount(with section: Int) -> Int
    {
        preconditionFailure("You have to Override getCellsCount Function first to be able to set number of cells count")
    }

    func getSectionsCount() -> Int
    {
        preconditionFailure("You have to Override getSectionsCount Function first to be able to set number of sections count")
    }


    // MARK: - Loading Progress
    // MARK: Show

    public func showProgressLoaderIndicator() {
        DispatchQueue.main.async {
//            self.loadingIndicator?.isHidden = false
            self.loadingIndicator?.startAnimating()
        }

    }


    // MARK: Hide

    public func hideProgressLoaderIndicator() {
        DispatchQueue.main.async {
            //self.loadingIndicator?.isHidden = true
            self.loadingIndicator?.stopAnimating()
        }
    }

}


// MARK: - UITableViewDataSource

extension BaseMusicListViewController: UITableViewDelegate, UITableViewDataSource {


    // MARK: Height for cell

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return getCellHeight()
    }

    // MARK: Number of Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.getSectionsCount()
    }

    // MARK: Number of rows

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getCellsCount(with: section)
    }


    // MARK: Cell for row

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: self.cellNibName!, for: indexPath)
        if(cell == nil) {
            cell = self.cellNib?.instantiate(withOwner: self, options: nil)[0] as? UITableViewCell
        }
        return getCustomCell(tableView, customCell: cell!, cellForRowAt: indexPath)
    }

    @objc func getCustomCell(_ tableView: UITableView, customCell cusotmCell: UITableViewCell, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        return cusotmCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectCellAt(indexPath: indexPath)
    }

    @objc func didSelectCellAt(indexPath: IndexPath) {


    }
}


