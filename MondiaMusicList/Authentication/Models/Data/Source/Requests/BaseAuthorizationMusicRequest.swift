//
//  BaseAuthorizationMusicRequest.swift
//  MondiaMusicList
//
//  Created by mac on 7/8/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation

public class BaseAuthorizationMusicRequest<R: Decodable, E: Decodable>: NSObject {

    var defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var isForcingCancel = false

    public override init() {
        super.init()
    }


    public func getAuthorizationMusicToken(from url: String) {

        if let urlComponents = URLComponents(string: url) {
            guard let url = urlComponents.url else { return }
            let session = URLSession.shared

            var request = URLRequest.init(url: url)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

            request.setValue(Constants.gateWayKeyValue, forHTTPHeaderField: Constants.gateWayKey)
            request.httpMethod = "POST"
            dataTask = session.dataTask(with: request) { [weak self] data, response, error in

                if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse.statusCode)
                }
                if let error = error, let response = response as? HTTPURLResponse
                {
                    if !(self?.isForcingCancel)!
                    {
                        self?.setErrorResponse(message: error.localizedDescription, errorCode: response.statusCode)
                    }

                } else if let data = data
                {
                    if let response = response as? HTTPURLResponse
                    {
                        let resultStatus = self?.getStatus(response)
                        switch resultStatus!
                        {
                        case .success:
                            self?.serializeSuccessResponse(from: data)
                        case .failure:
                            self?.serializeFailureResponse(from: data)
                        }
                    }
                }
                else
                {
                    self?.cancelRequest()
                }
            }
            dataTask?.resume()
        }
    }


    func getStatus(_ response: HTTPURLResponse) -> ResponseStatusEnum {
        switch response.statusCode {
        case 200...299: return .success
        default: return .failure
        }
    }


    func serializeSuccessResponse(from data: Data)
    {
        do {

            let response = try JSONDecoder().decode(R.self, from: data)
            self.onRequestSuccess(data: response)
        }
        catch let parseError as NSError
        {
            self.setErrorDecodingData(message: parseError.localizedDescription)
        }
    }

    func serializeFailureResponse(from data: Data)
    {
        do {

            let response = try JSONDecoder().decode(E.self, from: data)
            self.onRequestFail(error: response)
        }
        catch let parseError as NSError
        {
            self.setErrorDecodingData(message: parseError.localizedDescription)

        }
    }

    func setErrorDecodingData(message: String, encodingStatus: EncodingStatusEnum = EncodingStatusEnum.failure)
    {
        let error = ErrorModel.init(code: message, error: Constants.encodingErrorMsg.localized, message: message)

        respondWithError(error: error)
    }


    func setErrorResponse(message: String, errorCode: Int)
    {
        let error = ErrorModel.init(code: message, error: Constants.encodingErrorMsg.localized, message: message)
        respondWithError(error: error)

    }

    func respondWithError(error: ErrorModel)
    {
        self.onRequestFail(error: error as? E)
    }

    func onRequestSuccess(data: R?) {
        preconditionFailure("Override onRequestSuccess func -> BaseAuthorizationMusicRequest")
    }

    func onRequestFail(error: E?) {
        preconditionFailure("Override onRequestFail func -> BaseAuthorizationMusicRequest")
    }

    func cancelRequest() {
        dataTask?.cancel()
        isForcingCancel = true
    }
}
