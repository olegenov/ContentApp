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
    enum Constants {
        static let invalidUrl: String = "invalid url"
        static let unknownError: String = "unknown Error"
        static let decodeError: String = "failed to decode data"
        
        static let code200: String = "OK"
        static let code400: String = "bad request"
        static let code401: String = "not authorized"
        static let code403: String = "forbidden"
        static let code404: String = "not found"
        static let code500: String = "server error"
    }
    
    private final let baseUrl = "http://127.0.0.1:8080/api/"
    
    func postData<T: Encodable, U: Decodable>(urlString: String, parameters: T, responseType: U.Type, token: Bool, completion: @escaping (Result<U, ApiError>) -> Void) {
        guard let url = URL(string: baseUrl + urlString) else {
            completion(.failure(ApiError(Constants.invalidUrl)))
            return
        }
        
        var headers: HTTPHeaders = [:]
        
        if token {
            let tokenString = TokenManager.shared.getToken()
            headers["Authorization"] = "Bearer " + (tokenString ?? "")
        }
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: U.self) { response in
                self.handleResponse(response: response, completion: completion)
            }
    }
    
    func fetchData<T: Decodable>(urlString: String, responseType: T.Type, token: Bool, completion: @escaping (Result<T, ApiError>) -> Void) {
        guard let url = URL(string: baseUrl + urlString) else {
            completion(.failure(ApiError(Constants.invalidUrl)))
            return
        }
        
        var headers: HTTPHeaders = [:]
        
        if token {
            let tokenString = TokenManager.shared.getToken()
            headers["Authorization"] = "Bearer " + (tokenString ?? "")
        }
        
        AF.request(url, method: .get, headers: headers)
            .validate(statusCode: 200..<300)
            .responseData { response in
                self.handleDataResponse(response: response, completion: completion)
            }
    }
    
    private func handleResponse<T: Decodable>(response: AFDataResponse<T>, completion: @escaping (Result<T, ApiError>) -> Void) {
        switch response.result {
        case .success(let data):
            completion(.success(data))
        case .failure(_):
            if let statusCode = response.response?.statusCode {
                let apiError = ApiError(parseError(statusCode, response.data), statusCode)
                completion(.failure(apiError))
            } else {
                let apiError = ApiError(Constants.unknownError)
                completion(.failure(apiError))
            }
        }
    }
    
    private func handleDataResponse<T: Decodable>(response: AFDataResponse<Data>, completion: @escaping (Result<T, ApiError>) -> Void) {
        switch response.result {
        case .success(let data):
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                let apiError = ApiError(Constants.decodeError)
                completion(.failure(apiError))
            }
        case .failure(_):
            if let statusCode = response.response?.statusCode {
                let apiError = ApiError(parseError(statusCode, response.data), statusCode)
                completion(.failure(apiError))
            } else {
                let apiError = ApiError(Constants.unknownError)
                completion(.failure(apiError))
            }
        }
    }
    
    private func parseError(_ statusCode: Int, _ data: Data?) -> String {
        guard let data = data else {
            return Constants.unknownError
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            if let errorMessage = json?["error"] as? String {
                return errorMessage
            }
        } catch { 
            return parseHttpCode(statusCode)
        }
        
        return parseHttpCode(statusCode)
    }
    
    private func parseHttpCode(_ statusCode: Int) -> String {
        switch statusCode {
        case 200:
            return Constants.code200
        case 400:
            return Constants.code400
        case 401:
            return Constants.code401
        case 403:
            return Constants.code403
        case 404:
            return Constants.code404
        case _:
            if (statusCode > 500) {
                return Constants.code500
            }
            
            return Constants.unknownError
        }
    }
}
