//
//  DetailsView.swift
//  WeatherAppKB
//
//  Created by Użytkownik Gość on 11/06/2021.
//

import SwiftUI

struct DetailsView: View {
    var record: WeatherModel.WeatherRecord
    var body: some View {

        
        VStack(){
            Text(record.city).font(.system(size: 40))
            Text("\(record.latitude), \(record.longitude)").font(.system(size: 12))
        }
        Spacer()
        VStack(){
            VStack(spacing: 10){
                Text("Weather state: \(record.weather)")
                Text("Temperature: \(record.temperature,specifier: "%.1f")ºC")
                Text("Humidity: \(record.humidity,specifier: "%.1f")%")
                Text("Air pressure: \(record.pressure,specifier: "%.1f")mbar")
                Text("Wind: \(record.windSpeed,specifier: "%.1f")mph \(Direction(windDir: record.windDir))")
                Text("Visibility: \(record.visibility,specifier: "%.1f")miles")
                Text("Confidence: \(record.predictability)%")
            }
        }
        Spacer()
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(record: WeatherModel.WeatherRecord(woeId: ""))
    }
}
