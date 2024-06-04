//
//  NetworkingProvider.swift
//  Networking
//
//  Created by Germán González on 11/6/23.
//

import Foundation
import Alamofire

final class NetworkingProvider {
    
    // Instantiate it as singleton pattern
    static let shared = NetworkingProvider()
    
    // Base URL
    private let kBaseUrl = "https://gorest.co.in/public-api/"
    private let kStatusOk = 200...299
    private let kToken = "24cd152d462a9e0a0a73b5c5f005bb73ebae7798b60e47cad30f14d7c587558e"
    
    // Function charged of GET User Operation
    func getUser(id:Int, success: @escaping(_ user:User) -> (), failure: @escaping(_ error: Error?) -> ()){
        // Build the URL
        let url = "\(kBaseUrl)users/\(id)"
        
        // Build the Headers
        let headers:HTTPHeaders = [.authorization(bearerToken: kToken)]
        
        // Build the request
        AF.request(url, method: .get, headers: headers).validate(statusCode: kStatusOk).responseDecodable (of: UserResponse.self, decoder: DateDecoder()) {
            response in
            
            if let user = response.value?.data {
                success(user)
            } else {
               failure(response.error)
            }
        }
    }
    
    // Function charged of POST User Operation
    func addUser(user:NewUser, success: @escaping(_ user:User) -> (), failure: @escaping(_ error: Error?) -> ()) {
        // Build the URL
        let url = "\(kBaseUrl)users"
        
        // Build the Headers
        let headers:HTTPHeaders = [.authorization(bearerToken: kToken)]
        
        // Build the request
        AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default, headers: headers).validate(statusCode: kStatusOk).responseDecodable (of: UserResponse.self, decoder: DateDecoder()) {
            response in
            
            if let user = response.value?.data, user.id != nil {
                success(user)
            } else {
               failure(response.error)
            }
        }
    }
    
    // Function charged of PUT User Operation
    func updateUser(id:Int, user:NewUser, success: @escaping(_ user:User) -> (), failure: @escaping(_ error: Error?) -> ()) {
        // Build the URL
        let url = "\(kBaseUrl)users/\(id)"
        
        // Build the Headers
        let headers:HTTPHeaders = [.authorization(bearerToken: kToken)]
        
        // Build the request
        AF.request(url, method: .put, parameters: user, encoder: JSONParameterEncoder.default, headers: headers).validate(statusCode: kStatusOk).responseDecodable (of: UserResponse.self, decoder: DateDecoder()) {
            response in
            
            if let user = response.value?.data, user.id != nil {
                success(user)
            } else {
               failure(response.error)
            }
        }
    }
    
    // Function charged of DELETE User Operation
    func deleteUser(id:Int, success: @escaping() -> (), failure: @escaping(_ error: Error?) -> ()) {
        // Build the URL
        let url = "\(kBaseUrl)users/\(id)"
        
        // Build the Headers
        let headers:HTTPHeaders = [.authorization(bearerToken: kToken)]
        
        // Build the request
        AF.request(url, method: .delete, headers: headers).validate(statusCode: kStatusOk).response {
            response in
            
            if let error = response.error {
                failure(error)
            } else {
                success()
            }
        }
    }
}
