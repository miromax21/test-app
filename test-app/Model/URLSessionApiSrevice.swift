////
////  DataFunctions.swift
////  htc-weak-6
////
////  Created by maxim mironov on 30/04/2019.
////  Copyright © 2019 maxim mironov. All rights reserved.
////
//
//import Foundation
//import Alamofire
//protocol GetQuestionsProtocol{
//    
//    func getQuestions(tag: String, completion: @escaping ([ItemModel]) -> ())
////    func getQuestionsSession(tag: String, completion: @escaping ([ItemModel]) -> ())
//}
//class URLSessionApiSrevice:GetQuestionsProtocol {
//    let githubUrl = "https://api.stackexchange.com/2.2/questions?order=desc&sort=activity&site=stackoverflow&filter=!0WJ3YL7KJOsP46r755kycqqs8"
//    
//    var dataTask: URLSessionDataTask?
//    
//    func getQuestionsSession(tag: String, completion: @escaping ([ItemModel]) -> ()) {
//        let defaultSession = URLSession(configuration: .default)
//        dataTask?.cancel()
//        DispatchQueue.global(qos: .userInitiated).async {
//            let url = URL(string: self.githubUrl + "&tagged=\(tag)")!
//            self.dataTask = defaultSession.dataTask(with: url) { data, response, error in
//                    defer { self.dataTask = nil }
//                    if let error = error {
//                        DispatchQueue.main.async {
//                            completion([ItemModel]())
//                        }
//                        print(error)
//                        return
//                    }
//                    else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
//                        let serverDataModel = try? JSONDecoder().decode(ServerDataModel.self, from: data)
//                        guard serverDataModel != nil, let items = serverDataModel?.items else{
//                            DispatchQueue.main.async {
//                                completion([ItemModel]())
//                            }
//                            return
//                        }
//                        DispatchQueue.main.async {
//                            completion(items)
//                        }
//                    }
//                }
//            self.dataTask?.resume()
//        }
//    }
//
//    func getQuestionsAlamofire(tag: String, completion: @escaping ([ItemModel]) -> ()){
//        DispatchQueue.global(qos: .userInteractive).async{
//            Alamofire.request(self.githubUrl + "&tagged=\(tag)").responseJSON { response in
//                guard response.result.isSuccess,  let responceData = response.data else{
//                    completion([ItemModel]())
//                    return
//                }
//                let data = try? JSONDecoder().decode(ServerDataModel.self, from: responceData)
//                guard data != nil, let items = data?.items else{
//                     completion([ItemModel]())
//                     return
//                }
//                completion(items)
//            }
//        }
//    }
//}
