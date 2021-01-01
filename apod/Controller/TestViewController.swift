//
//  TestViewController.swift
//  apod
//
//  Created by Swamita on 01/01/21.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var url = URL.init(string: "https://apod.nasa.gov/apod/image/2101/2020_12_16_Kujal_Jizni_Pol_1500px-3.jpg")
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.loadImage(url: url!)

        // Do any additional setup after loading the view.
    }
    

    
}

extension UIImageView {
    func loadImage(url: URL) {
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
