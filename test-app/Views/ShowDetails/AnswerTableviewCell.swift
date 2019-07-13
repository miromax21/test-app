//
//  AnswerTableviewCell.swift
//  test-app
//
//  Created by maxim mironov on 28/05/2019.
//  Copyright © 2019 maxim mironov. All rights reserved.
//

import UIKit
class AnswerTableviewCell: UITableViewCell {
    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var voteCount: UILabel!
    @IBOutlet weak var editDate: UILabel!
    @IBOutlet weak var answertext: UILabel!
    
    func configureCell(param: Answer?, selected: Bool) {
        self.backgroundColor = selected ? .yellow : .none
        author.text = param?.owner?.displayName
        voteCount.text =  param?.voteCount == nil ? "0" : String(describing: param!.voteCount!)
        editDate.text = param?.creationDate != nil ? "\(Date.init(timeIntervalSince1970: TimeInterval(param!.creationDate!)).mediumDate())" : ""
        answertext.text = param?.body

    }
    
}
