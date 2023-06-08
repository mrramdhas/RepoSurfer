//
//  HTTPClient.swift
//  RepoSurfer
//
//  Created by Ramdhas on 2023-06-05.
//

import Foundation

protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: EndPoint, httpMethod: HTTPMethod, responseModel: T.Type) async throws -> T
}

extension HTTPClient {
    
    /// This function will perform network request
    func sendRequest<T: Decodable>(endpoint: EndPoint, httpMethod: HTTPMethod, responseModel: T.Type) async throws -> T {
        let config: URLSessionConfiguration = .default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        
        let urlComponents = URLComponents(string: endpoint.baseURL + endpoint.path)
        
        guard let url = urlComponents?.url else {
            throw RequestError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = endpoint.header
        request.httpMethod = httpMethod.rawValue
        
        let (data, response) = try await URLSession(configuration: config).data(for: request, delegate: nil)
        guard let response = response as? HTTPURLResponse else {
            throw RequestError.noResponse
        }
        switch response.statusCode {
        case 200...299:
            do {
                let decodedResponse = try JSONDecoder().decode(responseModel, from: data)
                return decodedResponse
            } catch {
                throw RequestError.decode
            }
        case 401:
            throw RequestError.unauthorized
        case 404:
            throw RequestError.notFound
        default:
            throw RequestError.unexpectedStatusCode(response.statusCode)
        }
    }
}
