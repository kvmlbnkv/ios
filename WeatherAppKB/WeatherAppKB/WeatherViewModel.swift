//
//  WeatherViewModel.swift
//  WeatherAppKB
//
//  Created by Użytkownik Gość on 06/05/2021.
//

import Foundation
import Combine
import CoreLocation
import MapKit

class WeatherViewModel: NSObject, ObservableObject, CLLocationManagerDelegate{
    
    //@Published private(set) var model: WeatherModel = WeatherModel(cities: ["Warsaw","Paris","Berlin","London","Barcelona","Rome","Los Angeles","Tokyo"])
    @Published private(set) var model: WeatherModel = WeatherModel(cities: ["0","523920","615702","638242","44418","721943","2442047","1118370"])
    let height: Int = 80
    let cornerRadius: Float = 25.0
    let weatherSize: Float = 0.8
    let layoutPriority: Double = 100
    let cityWidth: Float = 150
    var fetcher: MetaWeatherFetcher
    var locFetcher: MetaWeatherLocationFetcher
    var cancellables: Set<AnyCancellable> = []
    @Published var location: CLLocation?
    @Published var locationName: String
    let locationManager: CLLocationManager
    
    var records: Array<WeatherModel.WeatherRecord>{
        model.records
    }
    
    override init(){
        fetcher = MetaWeatherFetcher()
        locFetcher = MetaWeatherLocationFetcher()
        locationName = "Warsaw"
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        super.init()
        
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        for record in records{
            fetchWeather(record: record)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation]){
        location = locations.last
        let geocoder = CLGeocoder()
        if let locationG = location{
            geocoder.reverseGeocodeLocation(locationG){
                placemarks, error in self.locationName = placemarks![0].locality!
            }
        }
    }
    
    func fetchWeather(record: WeatherModel.WeatherRecord){
        let recordId = records.firstIndex(of: record) ?? 0
        
        if recordId==0{
            locFetcher.forecast(forId: location?.coordinate ?? CLLocationCoordinate2D(latitude: 50, longitude: 20)).sink(receiveCompletion: {completion in}, receiveValue: {locVal in
                self.fetcher.forecast(forId: String(locVal[0].woeid)).sink(receiveCompletion: {completion in}, receiveValue: {[self]response in
                    self.model.refreshMW(woeId: record.woeId, response: response, location: locationName)
                }).store(in: &self.cancellables)
            }).store(in: &cancellables)
        }
        else{
            fetcher.forecast(forId: record.woeId).sink(receiveCompletion: {completion in}, receiveValue: {[self]response in self.model.refreshMW(woeId: record.woeId, response: response, location: "")}).store(in: &cancellables)
        }
        
    }
    
    func refresh(record: WeatherModel.WeatherRecord){
        model.refresh(record: record)
    }
}
