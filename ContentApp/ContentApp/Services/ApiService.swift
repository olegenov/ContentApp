//
//  ApiManager.swift
//  ContentApp
//
//  Created by Никита Китаев on 29.02.2024.
//

import Foundation
import Alamofire

protocol APIServiceProtocol {
    func fetchData(url: String, completion: @escaping (Result<Data, Error>) -> Void)
    
    func postData(url: String, parameters: [String: Any], completion: @escaping (Result<Data, Error>) -> Void)
}

class APIService: APIServiceProtocol {
    private final let baseUrl = "https://127.0.0.1/api/"
    
    func postData(url: String, parameters: [String : Any], completion: @escaping (Result<Data, Error>) -> Void) {
        AF.request(baseUrl + url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData {
            response in switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func fetchData(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        AF.request(baseUrl + url).responseData { 
            response in switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
