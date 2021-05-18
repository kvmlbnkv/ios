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
        var weather: String = ["Clear", "LightCloud", "HeavyCloud", "Showers", "Rain", "Thunderstorm", "Snow"].randomElement() ?? "Clear"
        var temperature: Float = Float.random(in: -20.0...40.0)
        var humidity: Float = Float.random(in: 0.0...100.0)
        var windSpeed: Float = Float.random(in: 0.0...100.0)
        var windDir: Float = Float.random(in: 0.0..<360.0)
    }
    
    mutating func refresh(record: WeatherRecord){
        let recordId = records.firstIndex(of: record) ?? 0
        records[recordId].weather = ["Clear", "LightCloud", "HeavyCloud", "Showers", "Rain", "Thunderstorm", "Snow"].randomElement() ?? "Clear"
        records[recordId].temperature = Float.random(in: -20.0...40.0)
        records[recordId].humidity = Float.random(in: 0.0...100.0)
        records[recordId].windSpeed = Float.random(in: 0.0...100.0)
        records[recordId].windDir = Float.random(in: 0.0..<360.0)
        
        print("Record \(record) refreshed")
    }
}
