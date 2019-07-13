//
//  SetTagController.swift
//  test-app
//
//  Created by maxim mironov on 04/05/2019.
//  Copyright © 2019 maxim mironov. All rights reserved.
//

import UIKit
protocol SatTagDelegate {
    func setTag(tagIndex : Int)
}
class SetTagViewController: UIViewController {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var setTagButton: UIButton!
    
    var delegate : SatTagDelegate?
    var pickerData = [String]()
    var tagIndex:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.pickerView.selectRow(appDelegate.tagIndex, inComponent: 0, animated: true)
    }
    
    @IBAction func setTag(_ sender: Any) {
        dismiss(animated: true)
        delegate?.setTag(tagIndex: self.tagIndex)
    }
    @IBAction func cancelPopup(_ sender: Any) {
        dismiss(animated: false)
    }
}

extension SetTagViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.tagIndex = row
        //delegate?.setTag(tagIndex: row)
    }
    
}

