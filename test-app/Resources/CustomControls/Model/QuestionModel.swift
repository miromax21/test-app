//
//  QuestionModel.swift
//  test-app
//
//  Created by maxim mironov on 30/04/2019.
//  Copyright © 2019 maxim mironov. All rights reserved.
//

import Foundation
struct ServerDataModel: Codable {
    var items: [ItemModel]?
    var has_more: Bool
    var total: Int
}

struct ItemModel: Codable {
    var owner: ItemOwnerModel?
    //  var is_answered: Bool
    var answerCount: Int
    var score: Int?
    var title: String
    var lastEditDate: Int?
    var creationDate: Int
    //    var question_id:Int
    var isAnswered:Bool
    var answers: [Answer]?

    
    enum CodingKeys: String, CodingKey {
        case owner
        case answerCount = "answer_count"
        case score
        case title
        case lastEditDate = "last_edit_date"
        case creationDate = "creation_date"
        case answers
        case isAnswered  = "is_answered"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.owner = try container.decode(ItemOwnerModel.self, forKey: .owner)
        self.answerCount = try container.decode(Int.self, forKey: .answerCount)
        self.score = try? container.decode(Int.self, forKey: .score)
        self.title = try container.decode(String.self, forKey: .title)
        self.lastEditDate = try? container.decode(Int.self, forKey: .lastEditDate)
        self.creationDate = try container.decode(Int.self, forKey: .creationDate)
        self.answers = try? container.decode([Answer].self, forKey: .answers)
        self.isAnswered = try container.decode(Bool.self, forKey: .isAnswered)

    }
}
struct Answer: Codable  {
    var body: String?
    var owner: ItemOwnerModel?
    var creationDate:Int?
    var voteCount:Int? = 0
    
    enum CodingKeys: String, CodingKey {
        case body
        case owner
        case creationDate = "creation_date"
        case voteCount = "up_vote_count"
    }
    init (body:String?,owner:ItemOwnerModel?,creationDate:Int?){
        self.body = body
        self.owner = owner
        self.creationDate = creationDate
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.owner = try container.decode(ItemOwnerModel.self, forKey: .owner)
        self.creationDate = try container.decode(Int.self, forKey: .creationDate)
        self.body = try? container.decode(String.self, forKey: .body)
        if self.body != nil{
            htmlToString(htmlStr: &self.body!)
        }
        self.voteCount = try container.decode(Int?.self, forKey: .voteCount) ?? 0
    }
    func htmlToString(htmlStr:inout String){
        let scanner:Scanner = Scanner(string: htmlStr);
        var text:NSString? = nil;
        while scanner.isAtEnd == false {
            scanner.scanUpTo("<", into: nil);
            scanner.scanUpTo(">", into: &text);
            if text!.isEqual(to: "<\\br") {
                htmlStr = htmlStr.replacingOccurrences(of: "\(text ?? "")>", with: "\n");
            }else{
                htmlStr = htmlStr.replacingOccurrences(of: "\(text ?? "")>", with: "");
            }
        }
    }
}
struct ItemOwnerModel : Codable{
    var displayName: String?
    var link: String?
    var reputation: Int?
    var isAccepted:Bool?
    var userId: Int?
    enum CodingKeys : String, CodingKey {
        case displayName = "display_name"
        case link
        case reputation
        case isAccepted = "is_accepted"
        case userId = "user_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.displayName = try? container.decode(String.self, forKey: CodingKeys.displayName)
        self.link = try? container.decode(String.self, forKey: CodingKeys.link)
        self.reputation = try container.decode(Int.self, forKey: CodingKeys.reputation)
        self.isAccepted = try? container.decode(Bool.self, forKey: CodingKeys.isAccepted)
        self.userId = try? container.decode(Int.self, forKey: CodingKeys.userId)
    }
}

