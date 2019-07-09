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
    private static let baseUrl = "http://staging-gateway.mondiamedia.com/"
    public static let searchApiUrl = Constants.baseUrl + "v2/api/sayt/flat?query="
    public static let authenticationApiUrl = Constants.baseUrl + "v0/api/gateway/token/client"

    public static let authorizeResponseKey = "AuthorizationKey"
    public static let timeofAuthorizationKey = "AuthorizationTimeKey"

    public static let gateWayKey = "X-MM-GATEWAY-KEY"
    public static let gateWayKeyValue = "Ge6c853cf-5593-a196-efdb-e3fd7b881eca"

    // MARK: DateFormats Constants
    public static let yearMonthDayFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    public static let shortMonthDayYearFormat = "MMM dd,yyyy"

    // MARK: Image name placeholder
    public static let imagePlaceHolderName = "ic_Music_iphone_placeholder"

    // MARK: Localized Strings

    public static let cancel = "cancel"
    public static let retry = "retry"
    public static let alert = "alert"
    public static let error = "error"
    public static let warning = "warning"
    public static let ok = "ok"
    public static let musicListTitle = "musicList"
    public static let musicDetailsTitle = "musicDetails"

    public static let noInternetConnectionMsg = "networkConnectionMsg"
    public static let encodingErrorMsg = "encodingErrorMsg"


    // MARK: UITest accessability identifiers

    // Music list identifiers
    public static let tableViewIdentifier = "musicListTableView"
    public static let searchBarIdentifier = "searchBar"
    public static let loadingIndicatorIdentifier = "loadIndicator"
    public static let coverImageIdentifier = "coverImage"
    public static let zoomedCoverImageIdentifier = "zoomCoverImage"
    public static let artistNameLabelIdentifier = "artistName"
    public static let musicTitleLabelIdentifier = "musicTitle"
    public static let musicTypeLabelIdentifier = "musicType"

    public static let imageTestUrl = "http://staging-placebo.mondiamedia.com/api/fetch/image/article/300x300/3960494.jpg"
}
