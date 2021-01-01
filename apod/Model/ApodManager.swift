//
//  ApodManager.swift
//  apod
//
//  Created by Swamita on 01/01/21.
//

import Foundation

protocol ApodManagerDelegate {
    func didUpdateApod(_ apodManager: ApodManager,apod: ApodModel)
    func didFailWithError(error: Error)
}

struct ApodManager {
    let urlString = "https://api.nasa.gov/planetary/apod?api_key=HBNCycBMA1qmJFxJ3e4YpsPKy6cknhMr4VuQ89MI"
    
    var delegate: ApodManagerDelegate?
    
    func fetch(){
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                else {
                    if let safeData = data {
                        if let apod = self.parseJSON(safeData){
                            self.delegate?.didUpdateApod(self, apod: apod)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ apodData: Data) -> ApodModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ApodData.self, from: apodData)
            let todaysTitle = decodedData.title
            let todaysExp = decodedData.explanation
            let todaysUrl = decodedData.url
            let todaysHdurl = decodedData.hdurl
            let todaysDate = decodedData.date
            let todaysCr = decodedData.copyright
            
            let apod = ApodModel(title: todaysTitle, explanation: todaysExp, url: todaysUrl, hdurl: todaysHdurl, date: todaysDate, copyright: todaysCr)
            
            return apod
            
        }catch {
            delegate?.didFailWithError(error: error)
            print(error)
            return nil
        }
    }
}
