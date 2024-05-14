//
//  EndPoint.swift
//  challenge05
//
//  Created by Mina Hanna on 2024-05-14.
//

import Foundation

fileprivate let requestTimeOut: Double = 60

enum HTTPMethod: String{
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

protocol EndPoint{
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var urlSubFolder: String { get }
    var queryItems: [URLQueryItem] { get }
}

extension EndPoint {
    var urlComponents: URLComponents {
        var components = URLComponents(string: baseURL)!
        components.path = urlSubFolder
        components.queryItems = queryItems
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        var request =  URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: requestTimeOut)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0ZTZlNzY0YmE3OWEyMWZhMzkwZGRjNDEwNWJiMGI3NCIsInN1YiI6IjYyYjFhNDM1NzdiMWZiMDQzYmY4ZjMxOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.5IH1y8k3IUaZ6yeyKVvMRIgEevPTNw5x3YOCphL81D8", forHTTPHeaderField: "Authorization")
        
        return request
    }
    
}
