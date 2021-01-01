//
//  DetailViewController.swift
//  apod
//
//  Created by Swamita on 01/01/21.
//

import UIKit

class DetailViewController: UIViewController{

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var copyright: UILabel!
    
    var apodManager = ApodManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apodManager.delegate = self
        apodManager.fetch()
        // Do any additional setup after loading the view.
    }

}

extension DetailViewController: ApodManagerDelegate {
    func didUpdateApod(_ apodManager: ApodManager, apod: ApodModel) {
        DispatchQueue.main.async{
            //self.expLabel.text = apod.explanation
            self.titleLabel.text = apod.title
            self.dateLabel.text = apod.date
            self.textView.text = apod.explanation
            self.copyright.text = "© " + apod.copyright
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
