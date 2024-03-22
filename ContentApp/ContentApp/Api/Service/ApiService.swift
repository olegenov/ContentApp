//
//  ApiManager.swift
//  ContentApp
//
//  Created by Никита Китаев on 29.02.2024.
//

import Foundation
import Alamofire

protocol APIServiceProtocol {
    func fetchData<T: Decodable>(urlString: String, responseType: T.Type, token: Bool, completion: @escaping (Result<T, ApiError>) -> Void)
    
    func postData<T: Encodable, U: Decodable>(urlString: String, parameters: T, responseType: U.Type, token: Bool, completion: @escaping (Result<U, ApiError>) -> Void)
}

class APIService: APIServiceProtocol {
    private final let baseUrl = "http://127.0.0.1:8080/api/"
    
    func postData<T: Encodable, U: Decodable>(urlString: String, parameters: T, responseType: U.Type, token: Bool, completion: @escaping (Result<U, ApiError>) -> Void) {
        
        guard let url = URL(string: baseUrl+urlString) else {
            completion(.failure(ApiError("invalid url")))
            return
        }
        
        var headers: HTTPHeaders = [:]
        
        if token && TokenManager.shared.hasToken() {
            
            let token = TokenManager.shared.getToken()
            headers["Authorization"] = "Bearer " + (token ?? "")
            
        }
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).responseDecodable(of: U.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(_):
                if let responseData = response.data {
                    do {
                        if let errorJson = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any] {
                            if let errorMessage = errorJson["error"] as? String {
                                completion(.failure(ApiError(errorMessage)))
                                return
                            }
                        }
                    } catch {
                        completion(.failure(ApiError("network error")))
                        return
                    }
                }
                completion(.failure(ApiError("network error")))
            }
        }
    }
    
    func fetchData<T: Decodable>(urlString: String, responseType: T.Type, token: Bool, completion: @escaping (Result<T, ApiError>) -> Void) {
        
        guard let url = URL(string: baseUrl+urlString) else {
            completion(.failure(ApiError("invalid url")))
            return
        }
        
        var headers: HTTPHeaders = [:]
        
        if token && TokenManager.shared.hasToken() {
            
            let token = TokenManager.shared.getToken()
            
            headers["Authorization"] = "Bearer " + (token ?? "")
            
        }
        
        AF.request(url, method: .get, headers: headers).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(ApiError("invalid data")))
                }
            case .failure(_):
                completion(.failure(ApiError("network error")))
            }
        }
    }
}
