//
//  ViewController.swift
//  test-app
//
//  Created by maxim mironov on 30/04/2019.
//  Copyright © 2019 maxim mironov. All rights reserved.
//
import UIKit
import AVFoundation
class ViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    var items = [ItemModel]()
    var urlSession: GetQuestionsProtocol!
    var property = Property()
    var player: AVPlayer?
    let pagingSpinner = UIActivityIndicatorView(style: .gray)
    
    fileprivate func addTagButton() {
        let setTagBarButton = UIBarButtonItem(title: NSLocalizedString("set tag", comment: "set tag bar button item text"), style: .done, target: self, action: #selector(goToSetTag))
        self.navigationItem.leftBarButtonItem = setTagBarButton
        self.navigationItem.title = property.tags[0]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTagButton()
        setGestures()
       // self.urlSession = AlamofireApiServices.init(tag: property.tags[property.currentTagIndex], pageCount: property.itemsCountOnPage)
        
        self.urlSession = URLSessionApiSrevices.init(tag:  property.tags[property.currentTagIndex], pageCount: property.itemsCountOnPage)
        loadData()
        pagingSpinner.hidesWhenStopped = true
        tableView.tableFooterView = UIView()
        tableView.tableFooterView?.backgroundColor = .lightGray
        pagingSpinner.color = UIColor(red: 22.0/255.0, green: 106.0/255.0, blue: 176.0/255.0, alpha: 1.0)
        tableView.tableFooterView?.addSubview(pagingSpinner)
        tableView.tableFooterView?.isHidden = items.count == 0
    }
    
    override func viewWillLayoutSubviews() {
        guard let tableFooter = tableView.tableFooterView else {
            return
        }
        tableFooter.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 30)
        pagingSpinner.center = tableFooter.center
        tableView.tableFooterView = tableFooter
        
    }
    // MARK: setGestures
    func setGestures(){
        let rightSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        rightSwipeRecognizer.direction = UISwipeGestureRecognizer.Direction.right
        
        let pinchRecognizer = UIPinchGestureRecognizer()
        pinchRecognizer.addTarget(self, action: #selector(handlePinchGesture(_:)))
        
        self.view.addGestureRecognizer(rightSwipeRecognizer)
        self.view.addGestureRecognizer(pinchRecognizer)
        
        if #available(iOS 10.0, *) {
            let refreshControl = UIRefreshControl()
            let title = NSLocalizedString("downloading questions", comment: "downloading questions")
            refreshControl.attributedTitle = NSAttributedString(string: title)
            refreshControl.addTarget(self,
                                     action: #selector(refreshTable(sender:)),
                                     for: .valueChanged)
            tableView.refreshControl = refreshControl
        }
    }
    
    @objc private func refreshTable(sender: UIRefreshControl) {
        sender.beginRefreshing()
        loadData()
        sender.endRefreshing()
    }
    @objc func handlePinchGesture(_ gestureRecognizer: UIPinchGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            guard let url = Bundle.main.url(forResource: "rington", withExtension: "mp3") else { return }
            let playerItem = AVPlayerItem(url: url)
            player = AVPlayer(playerItem: playerItem)
            player?.play()
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { timer in
                self.player?.pause()
            }
        }
    }
    @objc func swiped(_ gesture: UISwipeGestureRecognizer) {
        goToSetTag()
    }
    
    
    func loadData()  {
        activityIndicator.startAnimating()
        self.tableView.alpha = 0
        self.urlSession.getQuestions(tag: self.property.tags[self.property.currentTagIndex]) { [unowned self]  (data:Questionanswer) in
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.tagIndex = self.property.currentTagIndex
            switch data{
                case .error(let items, let errorMessage):
                    self.items = items ?? []
                    self.alertMessage(alerts: errorMessage, okFunc: { [unowned self] in
                        if items == nil{
                            self.goToSetTag()
                        }
                    })
                case .success(let items):
                    self.items = items ?? []
            }
            
            self.tableView.reloadData()
            self.navigationItem.title = self.property.tags[appDelegate.tagIndex]
            self.activityIndicator.stopAnimating()
            UIView.animate(withDuration: 1.5, animations: {
                self.tableView.alpha = 1
            })
        }

    }
    
    func alertMessage(alerts:[String], okFunc:  @escaping ()->())  {
        var message = String()
        for a in alerts{
            message += "\(a)"
        }
        let alertController = UIAlertController(title: "УУпс...)", message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            okFunc()
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(actionOk)
        alertController.addAction(actionCancel)
        self.present(alertController, animated: true, completion: nil)
        
        self.activityIndicator.stopAnimating()
        UIView.animate(withDuration: 1.5, animations: {
            self.tableView.alpha = 1
        })
    }
    func insertCells(newItems : [ItemModel])  {
        self.items += newItems
        
        let indexPaths = (self.items.count - newItems.count ..< self.items.count).map { IndexPath(row: $0, section: 0) }
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: indexPaths, with: .automatic)
        self.tableView.endUpdates()
        self.pagingSpinner.stopAnimating()
    }
    
    @objc func goToSetTag()  {
        //   self.property.currentTagIndex = Int.random(in: 1..<self.property.tags.count - 1)
        //    loadData()
        //return
        let storyboard = UIStoryboard(name: String(describing: SetTagViewController.self), bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! SetTagViewController
        vc.delegate = self
        vc.pickerData = self.property.tags
        self.present(vc, animated: true)
        
    }
    
    
}

// MARK: TableViewDelegate

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ShowDetailsController.getInstance() as! ShowDetailsController
        let model = self.items[indexPath.row]
        vc.setUpParms(question: model)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuestionTableviewCell.identifier) as! QuestionTableviewCell
        let model = self.items[indexPath.row]
        cell.configureCell(param:model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let outOfRange = items.count >= 30
        tableView.tableFooterView?.isHidden = outOfRange
        if indexPath.row == items.count - 1 && !outOfRange {
            self.pagingSpinner.startAnimating()
            self.urlSession.next { [unowned self] (data) in
                switch data{
                case .error(let items, let errorMessage):
                    self.alertMessage(alerts: errorMessage, okFunc: { [unowned self] in
                        if items == nil{
                            self.goToSetTag()
                        }
                    })
                case .success(let items):
                    if items != nil{
                        self.insertCells(newItems: items!)
                    }
                }
            }
        }
        
        
    }
}

extension ViewController: SatTagDelegate{
    
    func setTag(tagIndex: Int) {
        self.property.currentTagIndex = tagIndex
        loadData()
    }
}

