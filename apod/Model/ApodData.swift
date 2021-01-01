//
//  ApodData.swift
//  apod
//
//  Created by Swamita on 01/01/21.
//

import Foundation

struct ApodData: Codable {
    let title: String
    let explanation: String
    let url: String
    let hdurl: String
}

struct ApodModel{
    let title: String
    let explanation: String
    let url: String
    let hdurl: String
}
