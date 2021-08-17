//
//  WeatherDataModel.swift
//  Lab6
//
//  Created by Student on 2020-03-24.
//  Copyright © 2020 Drashti Akbari. All rights reserved.
//

import Foundation

struct CovidData : Codable {
    let totalConfirmed : Int
    let totalDeaths : Int
    let totalRecovered : Int
    let areas : [Areas]
}

struct Areas : Codable {
    let lat : Double
    let long : Double
    let displayName : String
    let totalConfirmed : Int?
    let totalDeaths : Int?
    let totalRecovered : Int?
}

