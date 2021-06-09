//
//  MetaWeatherLocationFetcher.swift
//  WeatherAppKB
//
//  Created by Użytkownik Gość on 09/06/2021.
//

import Foundation
import Combine
import CoreLocation

class MetaWeatherLocationFetcher{
    
    func forecast(forId coordinates: CLLocationCoordinate2D) -> AnyPublisher<MetaWeatherLocationResponse, Error>{
        let url: URL = URL(string: "https://www.metaweather.com/api/location/search/?lattlong=\(coordinates.latitude),\(coordinates.longitude)")!
        return URLSession.shared.dataTaskPublisher(for: url).map{$0.data}.decode(type: MetaWeatherLocationResponse.self, decoder: JSONDecoder()).receive(on:RunLoop.main).eraseToAnyPublisher()
    }
}
