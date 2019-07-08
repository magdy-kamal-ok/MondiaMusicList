//
//  Constants.swift
//  MondiaMusicList
//
//  Created by mac on 7/8/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation

class Constants: NSObject {
    
    // MARK: Request Constants
    private static let baseUrl = "https://api.theMusicdb.org/"
    public static let baseUrlImage = "https://image.tmdb.org/t/p/w500"
    public static let apiUrl = "http://staging-gateway.mondiamedia.com/v2/api/sayt/flat?query="
    public static let apiTokenUrl = "https://staging-gateway.mondiamedia.com/v0/api/gateway/token/client"
    
    
    public static let gateWayKey      = "X-MM-GATEWAY-KEY"
    public static let gateWayKeyValue = "Ge6c853cf-5593-a196-efdb-e3fd7b881eca"
    
    // MARK: DateFormats Constants
    public static let yearMonthDayFormat = "yyyy-MM-dd"
    public static let shortMonthDayYear = "MMM dd,yyyy"
    
    // MARK: Image name placeholder
    public static let imagePlaceHolderName = "ic_Music_iphone_placeholder"
    
    // MARK: Localized Strings
    
    public static let cancel = "cancel"
    public static let retry = "retry"
    public static let alert = "alert"
    public static let error = "error"
    public static let warning = "warning"
    public static let ok = "ok"
    public static let EMPTY_TITLE_MSG = "emptyTitleMsg"
    public static let EMPTY_OVERVIEW_MSG = "emptyOverViewMsg"
    public static let NEW_Music_TITLE = "newMusic"
    public static let Music_LIST_TITLE = "MusicList"
    public static let MY_Music = "myMusic"
    public static let ALL_Music = "allMusic"
    public static let INTERNET_CONNECTION = "networkConnectionMsg"
    
    
    // MARK: UITest accessability identifiers
    
    // Music list identifiers
    public static let TABLEVIEW_IDENTIFIER = "MusicListTableView"
    public static let ADD_NEW_VIDEO_BTN_IDENTIFIER = "AddMusicw"
    public static let Load_More_INDICATOR_IDENTIFIER = "loadMore"
    public static let PULL_REFRESH_INDICATOR_IDENTIFIER = "pullRefresh"
    public static let LOADING_INDICATOR_IDENTIFIER = "loadIndicator"
    public static let POSTER_IMAGE_VIEW_IDENTIFIER = "posterImage"
    public static let ZOOM_POSTER_IMAGE_IDENTIFIER = "zoomPosterImage"
    public static let Music_TITLE_IDENTIFIER = "MusicTitle"
    public static let Music_OVERVIEW_IDENTIFIER = "MusicOverView"
    public static let Music_DATE_IDENTIFIER = "MusicDate"
    
    // new Music identifiers
    public static let NEW_POSTER_IMAGE_VIEW_IDENTIFIER = "newPosterImage"
    public static let NEW_Music_TITLE_IDENTIFIER = "newMusicTitle"
    public static let NEW_Music_OVERVIEW_IDENTIFIER = "newMusicOverView"
    public static let NEW_Music_PICKER_IDENTIFIER = "newMusicDate"
    public static let NEW_Music_ADD_BTN_IDENTIFIER = "newMusicAddBtn"
    public static let NEW_Music_DONE_BTN_IDENTIFIER = "newMusicDoneBtn"
    public static let NEW_Music_RESET_BTN_IDENTIFIER = "newMusicResetBtn"
    
    public static let IMAGE_TEST_URL = "https://image.tmdb.org/t/p/w500/xqR4ABkFTFYe8NDJi3knwWX7zfn.jpg"
}
