//
//  WeatherViewModel.swift
//  WeatherAppKB
//
//  Created by Użytkownik Gość on 06/05/2021.
//

import Foundation

class WeatherViewModel: ObservableObject{
    
    @Published private(set) var model: WeatherModel = WeatherModel(cities: ["Warsaw","Paris","Berlin","London","Barcelona","Los Angeles","Tokio"])
    
    var records: Array<WeatherModel.WeatherRecord>{
        model.records
    }
    
    func refresh(record: WeatherModel.WeatherRecord){
        model.refresh(record: record)
    }
}
