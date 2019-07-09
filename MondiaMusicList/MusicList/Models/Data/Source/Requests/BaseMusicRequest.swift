//
//  BaseMusicRequest.swift
//  MondiaMusicList
//
//  Created by mac on 7/8/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation

public class BaseMusicRequest<R: Decodable, E: Decodable>: NSObject {
    
    var defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var isForcingCancel = false

    public override init() {
        super.init()
    }
    

    public func getMusicRequsetData( from url: String) {
    
        if var urlComponents = URLComponents(string: url) {
            guard let url = urlComponents.url else { return }
            var request = URLRequest.init(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 20)
            request.setValue(getAuthorizationValueForHeaders(), forHTTPHeaderField: "Authorization")
            
            dataTask = defaultSession.dataTask(with: request) { [weak self] data, response, error in
                defer { self?.dataTask = nil }
                if let error = error,  let response = response as? HTTPURLResponse
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


    func getStatus(_ response: HTTPURLResponse) -> ResponseStatusEnum{
        switch response.statusCode {
            case 200...299: return .success
            default: return .failure
        }
    }
    
  
    func serializeSuccessResponse(from data:Data)
    {
        do{
            
            let response = try JSONDecoder().decode([R].self, from: data)
            self.onRequestSuccess(data: response)
        }
        catch let parseError as NSError
        {
            self.setErrorDecodingData(message: parseError.localizedDescription)
        }
    }
    
    func serializeFailureResponse(from data:Data)
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
    
    func setErrorDecodingData(message:String, encodingStatus:EncodingStatusEnum = EncodingStatusEnum.failure)
    {
        let error = ErrorModel.init(code: message, error: "encodeing error", message: message)
        
        respondWithError(error: error)
    }
    
    func getAuthorizationValueForHeaders()->String
    {
        if let auth = UserDefaultsHelper.getAuthorizeToken(key: Constants.authorizeResponseKey)
            
        {
            return "Bearer \(auth.accessToken!)"
        }
        
        return ""
    }
    func setErrorResponse(message:String, errorCode:Int)
    {
        let error = ErrorModel.init(code: message, error: "encodeing error", message: message)
        respondWithError(error: error)
        
    }
    
    func respondWithError(error:ErrorModel)
    {
        self.onRequestFail(error: error as? E)
    }
    
    func onRequestSuccess(data: [R]?) {
        preconditionFailure("Override onRequestSuccess func -> BaseMusicRequest")
    }
    
    func onRequestFail(error: E?) {
        preconditionFailure("Override onRequestFail func -> BaseMusicRequest")
    }
    
    func cancelRequest() {
        dataTask?.cancel()
        isForcingCancel = true
    }
}

