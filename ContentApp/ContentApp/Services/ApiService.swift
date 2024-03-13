//
//  ApiManager.swift
//  ContentApp
//
//  Created by Никита Китаев on 29.02.2024.
//

import Foundation
import Alamofire

protocol APIServiceProtocol {
    func fetchData(url: String, completion: @escaping (Result<Data, ApiError>) -> Void)
    
    func postData(url: String, parameters: [String: Any], completion: @escaping (Result<Data, ApiError>) -> Void)
    
    func extractToken(from data: Data) -> String?
}

class APIService: APIServiceProtocol {
    private final let baseUrl = "http://127.0.0.1:8080/api/"
    
    func postData(url: String, parameters: [String : Any], completion: @escaping (Result<Data, ApiError>) -> Void) {
        AF.request(baseUrl + url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData {
            response in switch response.result {
            case .success(let data):
                if let statusCode = response.response?.statusCode, 200..<300 ~= statusCode {
                    completion(.success(data))
                } else {
                    completion(.failure(ApiError(self.extractError(from: data) ?? "Unknown error")))
                }
            case .failure(_):
                completion(.failure(ApiError("Server error")))
            }
        }
    }
    
    func fetchData(url: String, completion: @escaping (Result<Data, ApiError>) -> Void) {
        AF.request(baseUrl + url).responseData {
            response in switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(_):
                completion(.failure(ApiError("Server error")))
            }
        }
    }
    
    func extractToken(from data: Data) -> String? {
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let token = json["token"] as? String {
                return token
            }
        } catch { }
        return nil
    }
    
    func extractError(from data: Data) -> String? {
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let errorMessage = json["error"] as? String {
                return errorMessage
            }
        } catch { }
        return nil
    }
}
