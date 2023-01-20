//
//  NetWorkManager.swift
//  AppNoticias
//
//  Created by Alisson William on 21/11/22.
//

import Foundation

enum ResultNewsError: Error {
    case badURL, noData, invalidJSON
}

class NetWorkManager {
    
    static let shared = NetWorkManager()
    
    struct Constans {
        static let newasAPI = URL(string: "https://web-ebac-ios.herokuapp.com/home")
    }
    
    private init() { }
    
    func getNews(completion: @escaping (Result<[ResultNews], ResultNewsError>) -> Void) {
        
        // Setup The url
        guard let url = Constans.newasAPI else {
            completion(.failure(.badURL))
            return
        }
        
        // Create a configuration
        let configuration = URLSessionConfiguration.default
        
        // Create a session
        let session = URLSession(configuration: configuration)
        
        // Create the task
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data else {
                completion(.failure(.invalidJSON))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(ResponseElement.self, from: data)
                completion(.success(result.home.results))
            } catch {
                print("Error info: \(error.localizedDescription)")
                completion(.failure(.noData))
            }
        }
        task.resume()
    }
}
