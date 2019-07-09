//
//  UserDefaultsHelper.swift
//  MondiaMusicList
//
//  Created by mac on 7/8/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//
import Foundation

class UserDefaultsHelper {
    
    static let defaults = UserDefaults.standard
    
    class func saveStringData(value : String , key : String){
        defaults.set(value  , forKey: key)
    }
    
    class func getStringFromUserDefaults(key : String)->String?{
        return defaults.string(forKey: key)
    }
    
    class func deleteStringFromUserDefaults(key:String){
        defaults.removeObject(forKey: key)
    }
    
    class func getAuthorizeToken(key : String)->AuthorizationToken?
    {
        return defaults.codable(AuthorizationToken.self, forKey: key)
    }
    
    class func setAuthorizeToken(key : String, value:AuthorizationToken)
    {
         defaults.set(codable: value, forKey: key)
    }
}
