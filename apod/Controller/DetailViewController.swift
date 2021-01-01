//
//  DetailViewController.swift
//  apod
//
//  Created by Swamita on 01/01/21.
//

import UIKit

class DetailViewController: UIViewController{

    @IBOutlet weak var expLabel: UILabel!
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
            self.expLabel.text = apod.explanation
            print("Hi")
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
