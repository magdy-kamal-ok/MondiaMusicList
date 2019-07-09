//
//  UserDefaultsExtension.swift
//  MondiaMusicList
//
//  Created by mac on 7/9/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    func set<T: Encodable>(codable: T, forKey key: String) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(codable)
            let jsonString = String(data: data, encoding: .utf8)!
            self.set(jsonString, forKey: key)
        } catch {
            print("Saving \"\(key)\" failed: \(error)")
        }
    }
    
    func codable<T: Decodable>(_ codable: T.Type, forKey key: String) -> T? {
        guard let jsonString = self.string(forKey: key) else { return nil }
        guard let data = jsonString.data(using: .utf8) else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode(codable, from: data)
    }
}
