//
//  Service.swift
//  AppStoreJSONAPI
//
//  Created by Sean on 2020/4/3.
//  Copyright © 2020 Sean. All rights reserved.
//

import Foundation

class Service {
    static let shared = Service()

    func fetchApps(searchText: String, completion: @escaping (Error?, [Result]?) -> ()) {
            let urlString = "https://itunes.apple.com/search?term=\(searchText)&entity=software"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(err, nil)
                return
            }
            
            guard let data = data else { return }
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                completion(nil, searchResult.results)
            } catch let jsonError {
                print("Failed to decode json error: ", jsonError)
                completion(jsonError, nil)
            }
            
        }.resume()
    }

    func fetchTopGrossing(completion: @escaping (AppGroup?, Error?) -> ()) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/50/explicit.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    func fetchGames(completion: @escaping (AppGroup?, Error?) -> ()) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/50/explicit.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    func fetchTopFree(completion: @escaping (AppGroup?, Error?) -> ()) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/50/explicit.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    func fetchAppGroup(urlString: String, completion: @escaping (AppGroup?, Error?) -> ()) {
        guard let url = URL(string: urlString) else { return }
                
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
//            print(String(data: data!, encoding: .utf8))
            
            if let err = err {
                completion(nil, err)
                return
            }
            
            do {
                let appGroup = try JSONDecoder().decode(AppGroup.self, from: data!)
                // success
                completion(appGroup, nil)
            } catch {
                completion(nil, error)
//                print("Failed to decode:", error)
            }
        }.resume()
    }
    
}
