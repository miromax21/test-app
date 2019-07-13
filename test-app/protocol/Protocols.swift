//
//  protocols.swift
//  test-app
//
//  Created by maxim mironov on 14/05/2019.
//  Copyright © 2019 maxim mironov. All rights reserved.
//

import Foundation
protocol GetQuestionsProtocol{
       // func getQuestions(tag:String, completion: @escaping ([ItemModel]?, String?) -> ())
    func next(completion: @escaping (_ responce:Questionanswer<ItemModel>) -> ())
    func getQuestions(tag:String, completion: @escaping (_ responce:Questionanswer<ItemModel>) -> ())
}
enum Questionanswer<T>{
    case error(items:[T]?, errorMessage:[String])
    case success(items:[T]?)
}


