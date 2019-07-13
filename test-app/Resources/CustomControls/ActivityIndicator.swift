import UIKit

struct ActivityIndicator {

    
    let view: UIView
    let viewForActivityIndicator = UIView()
    let activityIndicatorView = UIActivityIndicatorView()
    let loadingTextLabel = UILabel()

    func showActivityIndicator() {
        viewForActivityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        viewForActivityIndicator.backgroundColor = .yellow
        viewForActivityIndicator.backgroundColor = UIColor.white
        view.addSubview(viewForActivityIndicator)

        activityIndicatorView.center = CGPoint(x: self.view.frame.size.width / 2.0, y: (self.view.frame.size.height) / 2.0)
        
        loadingTextLabel.textColor = UIColor.black
        loadingTextLabel.text = "LOADING"
        loadingTextLabel.font = UIFont(name: "Avenir Light", size: 10)
        loadingTextLabel.sizeToFit()
        loadingTextLabel.center = CGPoint(x: activityIndicatorView.center.x, y: activityIndicatorView.center.y + 30)
        viewForActivityIndicator.addSubview(loadingTextLabel)

        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.style = .gray
        viewForActivityIndicator.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
    }
    
    func stopActivityIndicator() {
        viewForActivityIndicator.removeFromSuperview()
        activityIndicatorView.stopAnimating()
        activityIndicatorView.removeFromSuperview()
    }}
