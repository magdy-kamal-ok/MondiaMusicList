//
//  MusicDetailsViewController.swift
//  MondiaMusicList
//
//  Created by mac on 7/8/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import UIKit

enum RowType {
    case musicCoverImage
    case musicArtist
    case musicType
    case musicTitle
    case musicPublishDate
    case musicNumberOfTracks
    case musicRate
    case musicDuration

}
protocol MusicDetailViewDelegate: class {
    func didPressBackBtn()
}

class MusicDetailsViewController: UIViewController {

    @IBOutlet weak var musicDetailsTableView: UITableView!

    var musicModel: Music?
    var musicDetailsRows = [RowType]()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewCells()
        setTableViewDelegates()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTableViewSections()
        addLeftNavbarBackButton()
        setTitle()
    }
    func setTitle()
    {
        self.title = Constants.musicDetailsTitle.localized
    }
    func addLeftNavbarBackButton()
    {

        let backBarButton = UIBarButtonItem.init(image: UIImage.init(named: "backButton"), style: .plain, target: self, action: #selector(backButtonClick))
        navigationItem.leftBarButtonItem = backBarButton
    }
    @objc func backButtonClick()
    {
        self.navigationController?.popViewController(animated: true)
    }
}

extension MusicDetailsViewController
{
    func registerTableViewCells()
    {
        musicDetailsTableView.register(UINib.init(nibName: "MusicCoverImageTableViewCell", bundle: nil), forCellReuseIdentifier: "MusicCoverImageTableViewCell")
        musicDetailsTableView.register(UINib.init(nibName: "MusicInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "MusicInfoTableViewCell")
    }

    func setTableViewDelegates()
    {
        musicDetailsTableView.dataSource = self
        musicDetailsTableView.delegate = self
        musicDetailsTableView.estimatedRowHeight = 500
    }
    func setTableViewSections()
    {
        if let music = musicModel
        {
            if let cover = music.coverImage
            {
                if !(cover.medium?.isEmpty)!
                {
                    self.musicDetailsRows.append(.musicCoverImage)
                }
            }
            if let artist = music.artist
            {
                if !(artist.name?.isEmpty)!
                {
                    self.musicDetailsRows.append(.musicArtist)
                }
            }
            if let type = music.type
            {
                if !type.isEmpty
                {
                    self.musicDetailsRows.append(.musicType)
                }
            }
            if let title = music.title
            {
                if !title.isEmpty
                {
                    self.musicDetailsRows.append(.musicTitle)
                }
            }
            if let publishingDate = music.publishingDate
            {
                if !publishingDate.isEmpty
                {
                    self.musicDetailsRows.append(.musicPublishDate)
                }
            }
            if let numberOfTracks = music.numberOfTracks
            {
                if numberOfTracks != 0
                {
                    self.musicDetailsRows.append(.musicNumberOfTracks)
                }
            }
            if let statistics = music.statistics, let rate = statistics.popularity
            {
                if !rate.isEmpty
                {
                    self.musicDetailsRows.append(.musicRate)
                }
            }
            if let duration = music.duration
            {
                if duration != 0
                {
                    self.musicDetailsRows.append(.musicDuration)
                }
            }

        }

        self.musicDetailsTableView.reloadData()
    }

}

extension MusicDetailsViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.musicDetailsRows.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let rowType = self.musicDetailsRows[indexPath.section]
        switch rowType {
        case .musicCoverImage:
            return 350
        default:
            return UITableView.automaticDimension
        }

    }



    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.musicDetailsRows[indexPath.section]

        switch row {
        case .musicCoverImage:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCoverImageTableViewCell", for: indexPath) as! MusicCoverImageTableViewCell
            cell.configureCell(coverImage: self.musicModel?.coverImage)

            return cell
        case .musicArtist:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MusicInfoTableViewCell", for: indexPath) as! MusicInfoTableViewCell
            cell.configureCell(title: "Artist", desc: (self.musicModel?.artist?.name)!)
            return cell
        case .musicType:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MusicInfoTableViewCell", for: indexPath) as! MusicInfoTableViewCell
            cell.configureCell(title: "Type", desc: (self.musicModel?.type)!)
            return cell
        case .musicTitle:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MusicInfoTableViewCell", for: indexPath) as! MusicInfoTableViewCell
            cell.configureCell(title: "Title", desc: (self.musicModel?.title)!)
            return cell
        case .musicPublishDate:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MusicInfoTableViewCell", for: indexPath) as! MusicInfoTableViewCell
            let formattedStrDate = HelperDateFormatter.formatDate(date: HelperDateFormatter.getDateFromString(dateString: (self.musicModel?.publishingDate)!, format: Constants.yearMonthDayFormat), format: Constants.shortMonthDayYearFormat)
            cell.configureCell(title: "Publish Date", desc: formattedStrDate)
            return cell
        case .musicNumberOfTracks:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MusicInfoTableViewCell", for: indexPath) as! MusicInfoTableViewCell
            cell.configureCell(title: "Number Of Tracks", desc: String((self.musicModel?.numberOfTracks)!))
            return cell
        case .musicRate:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MusicInfoTableViewCell", for: indexPath) as! MusicInfoTableViewCell
            cell.configureCell(title: "Rate", desc: (self.musicModel?.statistics?.popularity)!)
            return cell
        case .musicDuration:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MusicInfoTableViewCell", for: indexPath) as! MusicInfoTableViewCell
            cell.configureCell(title: "Duration", desc: String((self.musicModel?.duration)!))
            return cell

        }
    }

}
