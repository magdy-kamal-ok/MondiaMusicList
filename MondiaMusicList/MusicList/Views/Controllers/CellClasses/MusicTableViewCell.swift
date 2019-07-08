//
//  MusicTableViewCell.swift
//  MondiaMusicList
//
//  Created by mac on 7/8/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import UIKit

class MusicTableViewCell: UITableViewCell {
    
    // MARK: outlets
    @IBOutlet weak var posterImageView: CustomImageView!
    @IBOutlet weak var artistNameLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    // MARK: Parameters
    var imageTapGesture = UITapGestureRecognizer()
    var zoomImageView:UIImageView?
    var startingFrame:CGRect?
    var blackBackgroundView:UIView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
        // Configure the view for the selected state
    }
    
    func configureCell(music:Music)
    {
        loadImageFromCover(cover: music.coverImage)
        setCellData(music: music)
    }
    
    private func setCellData(music:Music)
    {
        self.titleLbl.text = music.title
        self.typeLbl.text = music.type
        if let artist = music.artist
        {
            self.artistNameLbl.text = artist.name
        }
        setImagesControl()
    }
    private func loadImageFromCover(cover:CoverImage?)
    {
        if let cover = cover, let mediumPath = cover.medium
        {
            self.posterImageView.loadImageUsingUrlString(urlString: mediumPath, placeHolderImage: UIImage.init(named: Constants.imagePlaceHolderName))
        }
    }
    private func setImageViewsAccessibility()
    {
        self.posterImageView.accessibilityIdentifier = Constants.POSTER_IMAGE_VIEW_IDENTIFIER
        self.artistNameLbl.accessibilityIdentifier = Constants.Music_TITLE_IDENTIFIER
        self.titleLbl.accessibilityIdentifier = Constants.Music_OVERVIEW_IDENTIFIER
        self.typeLbl.accessibilityIdentifier = Constants.Music_DATE_IDENTIFIER
    }
    fileprivate func setImagesControl(){
       
        self.posterImageView.isUserInteractionEnabled = true
        self.imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleZoomTap(_:)))
        self.posterImageView.addGestureRecognizer(self.imageTapGesture)
        self.setImageViewsAccessibility()
    }
    
    @objc func handleZoomTap(_ sender: UITapGestureRecognizer)
    {
        
        if let imageView = imageTapGesture.view as? UIImageView
        {
            self.performZoomInForStartingImageView(startingImageView: imageView)
        }
    }
    func performZoomInForStartingImageView(startingImageView:UIImageView)
    {
        self.zoomImageView = startingImageView
        

        startingFrame = startingImageView.superview?.convert(startingImageView.frame, to: nil)
        let zoomingImageView = UIImageView(frame: startingFrame!)
        zoomingImageView.accessibilityIdentifier = Constants.ZOOM_POSTER_IMAGE_IDENTIFIER
        zoomingImageView.image = startingImageView.image
        zoomingImageView.isUserInteractionEnabled = true
        zoomingImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleZoomOutTap)))
        if let keyWindow = UIApplication.shared.keyWindow
        {
            blackBackgroundView = UIView(frame: keyWindow.frame)
            blackBackgroundView?.alpha = 0
            blackBackgroundView?.backgroundColor = UIColor.black
            keyWindow.addSubview(blackBackgroundView!)
            keyWindow.addSubview(zoomingImageView)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                
                self.blackBackgroundView?.alpha = 1
                let height = (self.startingFrame?.height)! / (self.startingFrame?.width)! * keyWindow.frame.width
                zoomingImageView.frame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
                zoomingImageView.center = keyWindow.center
                
            }, completion: nil)
            
        }
    }
    
    @objc func handleZoomOutTap(tapGesture:UITapGestureRecognizer)
    {
        if let zoomOutImageView = tapGesture.view as? UIImageView{
            zoomOutImageView.layer.cornerRadius = 16
            zoomOutImageView.layer.masksToBounds = true
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                
                zoomOutImageView.frame = self.startingFrame!
                self.blackBackgroundView?.alpha = 0
            }, completion: { (completed:Bool) in
                zoomOutImageView.removeFromSuperview()
            })
            
        }
    }
}
