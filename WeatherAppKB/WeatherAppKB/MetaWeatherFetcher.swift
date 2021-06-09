//
//  MetaWeatherFetcher.swift
//  WeatherAppKB
//
//  Created by Użytkownik Gość on 09/06/2021.
//

import Foundation
import Combine
import CoreLocation

class MetaWeatherFetcher{
    
    func forecast(forId woeId: String) -> AnyPublisher<MetaWeatherResponse, Error>{
        let url: URL = URL(string: "https://www.metaweather.com/api/location/\(woeId)/")!
        return URLSession.shared.dataTaskPublisher(for: url).map{$0.data}.decode(type:MetaWeatherResponse.self, decoder: JSONDecoder()).receive(on:RunLoop.main).eraseToAnyPublisher()
        
    }
}
