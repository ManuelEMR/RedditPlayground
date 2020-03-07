//
//  ImageDownloader.swift
//  RedditApp
//
//  Created by Manuel Munoz on 06/03/2020.
//  Copyright © 2020 Manuel Munoz. All rights reserved.
//

import Foundation

class ImageDownloader {
    
    private lazy var defaultSession: URLSession = {
      let configuration = URLSessionConfiguration.default
      
      return URLSession(configuration: configuration)
    }()
    
    private var tasks: [String: URLSessionDataTask] = [:]
    private var memoryCache: [String: Data] = [:]
    
    func download(urlString: String?, completionHandler: @escaping (Result<Data, Error>) -> Void) {
        guard let nonOpt = urlString, let url = URL(string: nonOpt) else { return }
        
        print("LOading image: \(nonOpt)")
        tasks[nonOpt]?.cancel()
        
        if let memoryData = memoryCache[nonOpt] {
            completionHandler(.success(memoryData))
            return
        }
        
        tasks[nonOpt] = defaultSession.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
                return
            }
            
            if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                
                self?.memoryCache[nonOpt] = data
                DispatchQueue.main.async {
                    completionHandler(.success(data))
                }
                return
            }
            
            //TODO: Send unknown error
        }
        tasks[nonOpt]?.resume()
    }
}
