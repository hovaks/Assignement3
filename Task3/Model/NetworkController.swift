//
//  NetworkController.swift
//  assignement
//
//  Created by Hovak Davtyan on 10/12/18.
//  Copyright © 2018 Hovak Davtyan. All rights reserved.
//

import UIKit
import Alamofire

class NetworkController {
    
    var headers = ["content-type" : "application/json",
                   "x-apikey" : "a5b39dedacbffd95e1421020dae7c8b5ac3cc"]
    private let baseURL = "https://stdevtask3-0510.restdb.io/rest"
    
    //Get Contacts
    func loadContacts(
        completion: @escaping ([Contact]?) -> Void)
    {
        let urlString = baseURL + "/contacts"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        Alamofire.request(url,
                          method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: headers)
            .responseData { response in
                switch response.result {
                case .success:
                    print("Success")
                    guard
                        let data = response.data
                        else { return completion(nil) }
                    do {
                        //Serialize Products
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let contacts = try decoder.decode([Contact].self, from: data)
                        return completion(contacts)
                    } catch let error {
                        print(error)
                        return completion(nil)
                    }
                    
                case.failure:
                    print("Failure")
                    return completion(nil)
                }
        }
    }
    
    func deleteContact(_ contact: Contact,
                       completion: @escaping (Error?) -> Void) {
        //Delete Contact
        let urlString = baseURL + "/contacts" + "/\(contact._id)"
        guard let url = URL(string: urlString) else {
            return
        }
        
        Alamofire.request(url,
                          method: .delete,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: headers).responseData { response in
                            return completion(response.result.error)
        }
        
        //Delete Image
        guard let imageID = contact.images?.first else { return }
        let imageURLString = "https://stdevtask3-0510.restdb.io/media/" + "\(imageID)"
        guard let imageURL = URL(string: imageURLString) else {
            return
        }
        
        Alamofire.request(imageURL,
                          method: .delete,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: headers).responseData { response in
                            return completion(response.result.error)
        }
    }
    
    func addContact(withData data: [String : Any],
                    image: UIImage?,
                    completion: @escaping (Error?) -> Void) {
        
        let urlString = baseURL + "/contacts"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let imageURLString =  "https://stdevtask3-0510.restdb.io/media/"
        guard let imageURL = URL(string: imageURLString) else {
            return
        }
        
        var parameters = data
        
        if let image = image {
            let imageData = image.jpegData(compressionQuality: 1.0)!
            
            Alamofire.upload(imageData,
                             to: imageURL,
                             method: .post,
                             headers: headers).responseData { response in
                                switch response.result {
                                case .success:
                                    guard
                                        let data = response.data
                                        else { return }
                                    do {
                                        //Serialize Products
                                        let decoder = JSONDecoder()
                                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                                        let image = try decoder.decode(Image.self, from: data)
                                        //Incomplete Implementation
                                    } catch let error {
                                        print(error)
                                    }
                                    
                                case.failure:
                                    print("Failure")
                                }
                                
            }
        }
        
        
        Alamofire.request(url,
                          method: .post,
                          parameters: data,
                          encoding: JSONEncoding.default,
                          headers: headers)
            .responseData { response in
                switch response.result {
                case .success:
                    guard
                        let statusCode = response.response?.statusCode
                        else { return }
                    if statusCode == 201 {
                        return completion(nil)
                    }
                    
                case .failure(let error):
                    return completion(error)
                }
        }
    }
}
