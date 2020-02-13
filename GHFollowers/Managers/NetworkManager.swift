//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Dmitrii Voronin on 08.01.2020.
//  Copyright © 2020 Mithfor. All rights reserved.


import UIKit

class NetworkManager {
    
    static let shared           = NetworkManager()
    let cache                   = NSCache<NSString, UIImage>()
    private let baseURL: String = "https://api.github.com/users/"
    
    private init() {}
    
    func getFollowers(for username: String,
                      page: Int,
                      completed: @escaping (Result<[Follower], GFError>) -> Void) {
        
        let endpoint = baseURL + "\(username)/followers?per_page=\(AppConstants.followersOnPage)&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUserName))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 200 else {
                    completed(.failure(.invalidResponse))
                    return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func getUserInfo(for username: String,
                     completed: @escaping (Result<User, GFError>) -> Void) {
        
          let endpoint = baseURL + "\(username)"
          
          guard let url = URL(string: endpoint) else {
              completed(.failure(.invalidUserName))
              return
          }
          
          let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
              
              if let _ = error {
                  completed(.failure(.unableToComplete))
                  return
              }
              
              guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                      completed(.failure(.invalidResponse))
                      return
              }
              
              guard let data = data else {
                  completed(.failure(.invalidData))
                  return
              }
              
              do {
                  let decoder                 = JSONDecoder()
                decoder.dateDecodingStrategy  = .iso8601
                  let user                    = try decoder.decode(User.self, from: data)
                  completed(.success(user))
              } catch {
                  completed(.failure(.invalidData))
              }
          }
          
          task.resume()
      }
    
    func downLoadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image  = cache.object(forKey: cacheKey) {
            completed(image)
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    completed(nil)
                    return
                }   
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
        task.resume()
    }
}
