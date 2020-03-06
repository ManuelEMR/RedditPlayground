//
//  RedditRepository.swift
//  RedditApp
//
//  Created by Manuel Munoz on 05/03/2020.
//  Copyright © 2020 Manuel Munoz. All rights reserved.
//

import Foundation

class RedditRepository {
    
    func login(code: String, redirectURI: String, completionHandler: @escaping (Result<AccessTokenResponse, Error>) -> Void) {
        request(endpoint: .accessToken(code: code, redirectURI: redirectURI), completionHandler: completionHandler)
    }
    
    private func request<T: Decodable>(endpoint: RedditAPI, completionHandler: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: endpoint.url) else {
            return print("Malformed url \(endpoint.url)")
        }
        
        var request = URLRequest(url: url)
        request.setValue(authCredentials, forHTTPHeaderField: "Authorization")
        endpoint.headers?.forEach {
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        request.httpMethod = endpoint.method
        request.httpBody = endpoint.body
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {
                print("error", error ?? "Unknown error")
                    completionHandler(.failure(error ?? NSError(domain: "Unkown error", code: -1, userInfo: nil)))
                return
            }

            guard (200 ... 299) ~= response.statusCode else { 
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                completionHandler(.failure(error ?? NSError(domain: "Unkown error", code: response.statusCode, userInfo: nil)))
                return
            }

            do {
                let obj = try self.decoder.decode(T.self, from: data)
                completionHandler(.success(obj))
            } catch let e {
                completionHandler(.failure(e))
            }
        }
        task.resume()
    }
    
    var decoder: JSONDecoder {
        let dec = JSONDecoder()
        dec.keyDecodingStrategy = .convertFromSnakeCase
        return dec
    }
    
    var credentials: String {
        "KuUP0BXhatcrFA:"
    }
    
    var authCredentials: String? {
        guard let authCredentials = credentials.data(using: .utf8)?.base64EncodedString() else { return nil }
        return "Basic \(authCredentials)"
    }
}
