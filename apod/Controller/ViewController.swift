//
//  ViewController.swift
//  apod
//
//  Created by Swamita on 01/01/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var apodImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var imageUrl: String = "https://apod.nasa.gov/apod/image/2101/2020_12_16_Kujal_Jizni_Pol_1500px-3.jpg"
    
    var apodManager = ApodManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        apodManager.delegate = self
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let date = dateFormatter.string(from: Date())
        
        if date == todaysApod.date{
            self.titleLabel.text = todaysApod.title
            self.imageUrl = todaysApod.url
        }else {
            apodManager.fetch()
        }
        
        var url = URL.init(string: imageUrl)
        self.apodImage.load(url: url!)
        
        // Do any additional setup after loading the view.
    }
    
    
    
}

extension ViewController: ApodManagerDelegate{
    func didUpdateApod(_ apodManager: ApodManager, apod: ApodModel) {
        DispatchQueue.main.async{
            self.titleLabel.text = apod.title
            self.imageUrl = apod.url
            print(self.imageUrl)
            
            
        }
    }
    
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
        let alert = UIAlertController(title: "Error", message: "Cannot fetch APOD :( Try again!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Okay", style: .default, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
