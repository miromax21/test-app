//
//  QuestionTableviewCell.swift
//  test-app
//
//  Created by maxim mironov on 05/05/2019.
//  Copyright © 2019 maxim mironov. All rights reserved.
//

import UIKit
class QuestionTableviewCell: UITableViewCell {
    //var selected : Bool = false
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var answersCount: UILabel!
    @IBOutlet weak var editDate: UILabel!
    func configureCell(param:ItemModel) {
        question.text  = param.title
        author.text = param.owner?.displayName ?? ""
        answersCount.text = "\(param.answerCount)"
        editDate.text = (param.lastEditDate != nil) ? "\(Date.init(timeIntervalSince1970: TimeInterval(param.lastEditDate!)).mediumDate())" : "\(Date.init(timeIntervalSince1970: TimeInterval(param.creationDate)).mediumDate())"
    }

    
}
