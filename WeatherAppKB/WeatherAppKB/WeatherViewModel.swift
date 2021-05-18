//
//  WeatherViewModel.swift
//  WeatherAppKB
//
//  Created by Użytkownik Gość on 06/05/2021.
//

import Foundation

class WeatherViewModel: ObservableObject{
    
    @Published private(set) var model: WeatherModel = WeatherModel(cities: ["Warsaw","Paris","Berlin","London","Barcelona","Rome","Los Angeles","Tokio"])
    let height: Int = 80
    let cornerRadius: Float = 25.0
    let weatherSize: Float = 0.8
    
    var records: Array<WeatherModel.WeatherRecord>{
        model.records
    }
    
    func refresh(record: WeatherModel.WeatherRecord){
        model.refresh(record: record)
    }
}
