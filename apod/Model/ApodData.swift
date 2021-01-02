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
    let date: String
    let copyright: String
}

struct ApodModel {
    let title: String
    let explanation: String
    let url: String
    let hdurl: String
    let date: String
    let copyright: String
}

struct TodaysData {
    let title: String
    let explanation: String
    let url: String
    let hdurl: String
    let date: String
    let copyright: String
    
}

var todaysApod = TodaysData(title: "", explanation: "", url: "", hdurl: "", date: "", copyright: "")


