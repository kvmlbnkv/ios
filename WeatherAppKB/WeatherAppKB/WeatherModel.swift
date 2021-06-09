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
            records.append(WeatherRecord(woeId:city))
        }
    }
    
    struct WeatherRecord: Identifiable, Equatable{
        var id: UUID = UUID()
        var city: String = "Warsaw"
        var latitude: Double = 0.0
        var longitude: Double = 0.0
        var woeId: String
        var weather: String = ["Clear", "Light Cloud", "Heavy Cloud", "Showers", "Light Rain", "Heavy Rain", "Thunderstorm", "Hail", "Snow"].randomElement() ?? "Clear"
        var temperature: Float = Float.random(in: -20.0...40.0)
        var humidity: Float = Float.random(in: 0.0...100.0)
        var windSpeed: Float = Float.random(in: 0.0...100.0)
        var windDir: Float = Float.random(in: 0.0..<360.0)
    }
    
    mutating func refresh(record: WeatherRecord){
        let recordId = records.firstIndex(of: record) ?? 0
        records[recordId].weather = ["Clear", "Light Cloud", "Heavy Cloud", "Showers", "Light Rain", "Heavy Rain", "Thunderstorm", "Hail", "Snow"].randomElement() ?? "Clear"
        records[recordId].temperature = Float.random(in: -20.0...40.0)
        records[recordId].humidity = Float.random(in: 0.0...100.0)
        records[recordId].windSpeed = Float.random(in: 0.0...100.0)
        records[recordId].windDir = Float.random(in: 0.0..<360.0)
        
        print("Record \(record) refreshed")
    }
    
    mutating func refreshMW(woeId: String, response: MetaWeatherResponse, location: String){
        let recordId = records.firstIndex(where: {$0.woeId==woeId}) ?? 0
        if recordId == 0{
            records[recordId].city = "\(location)(\(response.title))"
        }
        else{
            records[recordId].city = response.title
        }
        let lattLong = response.lattLong.components(separatedBy: ",")
        records[recordId].latitude = Double(lattLong[0])!
        records[recordId].longitude = Double(lattLong[1])!
        records[recordId].weather = response.consolidatedWeather[0].weatherStateName
        records[recordId].temperature = Float(response.consolidatedWeather[0].theTemp)
        records[recordId].humidity = Float(response.consolidatedWeather[0].humidity)
        records[recordId].windSpeed = Float(response.consolidatedWeather[0].windSpeed)
        records[recordId].windDir = Float(response.consolidatedWeather[0].windDirection)
    }
}
