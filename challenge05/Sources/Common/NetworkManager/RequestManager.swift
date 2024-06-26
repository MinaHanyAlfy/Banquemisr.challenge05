//
//  RequestManager.swift
//  challenge05
//
//  Created by Mina Hanna on 2024-05-14.
//

import Foundation
import Combine

public class RequestManager {
    /// Network Request Manager Using Combine
    /// - Parameters:
    ///   - request: EndPoint Request That have (baseURL-method'POST-GET-PUT-DELETE'-urlSubFolder-queryItems)
    ///   - model: Model is Generic Type To Response Specific & Generic Object (String-JSON-Int-....)
    /// - Returns: Object Or ErrorMessage
    public class func beginRequest<T: Decodable>(request: EndPoint, model: T.Type) -> AnyPublisher<T,ErrorMessage> {
        
        let urlRequest = request.request
        
        return URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .tryMap { (data, response) in
                guard let httpURLResponse = response as? HTTPURLResponse else {
                    throw ErrorMessage.InvalidResponse
                }
                
                guard 200...300 ~= httpURLResponse.statusCode else {
                    print("Status Code: ",httpURLResponse.statusCode)
                    throw ErrorMessage.InvalidData
                }
                
                let dataString = String(data: data, encoding: .utf8) ?? ""
//                print("\n ________ API \(request) Response ______\n ")
//                print("__________ \n \(dataString.count) \n ___________")

                return data
            }
            .decode(type: model.self, decoder: JSONDecoder())
            .mapError({ error -> ErrorMessage in
//                print("\n ________ API \(request) Error ______ ")
//                print("-Error-: ", error)
                return error as? ErrorMessage ?? .InvalidResponse
            })
            .eraseToAnyPublisher()
    }
    
}
