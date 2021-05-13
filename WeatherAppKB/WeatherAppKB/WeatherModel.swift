//
//  WeatherModel.swift
//  WeatherAppKB
//
//  Created by Użytkownik Gość on 06/05/2021.
//

import Foundation

struct WeatherModel{
    var records: Array<WeatherRecord> = []
    
    init(cities: Array<String>){
        for city in cities{
            records.append(WeatherRecord(city:city))
        }
    }
    
    struct WeatherRecord: Identifiable, Equatable{
        var id: UUID = UUID()
        var city: String
        var weather: String = "Clear"
        var temperature: Float = Float.random(in: -20.0...40.0)
        var humidity: Float = Float.random(in: 0.0...100.0)
        var windSpeed: Float = Float.random(in: 0.0...100.0)
        var windDir: Float = Float.random(in: 0.0..<360.0)
    }
    
    mutating func refresh(record: WeatherRecord){
        //records.firstIndex(of: record) ?? 0
        records[0].temperature = Float.random(in: -20.0...40.0)
        print("Record \(record) refreshed")
    }
}
