//
//  MusicCoverImageTableViewCell.swift
//  MondiaMusicList
//
//  Created by mac on 7/8/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import UIKit

class MusicCoverImageTableViewCell: UITableViewCell {

    @IBOutlet weak var coverImageView: CustomImageView!
    weak var musicDetailViewDelegate:MusicDetailViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(coverImage:CoverImage?)
    {
        loadImageFromCover(cover: coverImage)
    }
    

    private func loadImageFromCover(cover:CoverImage?)
    {
        if let cover = cover, let mediumPath = cover.medium
        {
            self.coverImageView.loadImageUsingUrlString(urlString: mediumPath, placeHolderImage: UIImage.init(named: Constants.imagePlaceHolderName))
        }
    }
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        self.musicDetailViewDelegate?.didPressBackBtn()
    }
    
}
