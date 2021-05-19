//
//  ContentView.swift
//  WeatherAppKB
//
//  Created by Użytkownik Gość on 06/05/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: WeatherViewModel
    var body: some View {
        ScrollView(.vertical){ //przewijanie listy miast
            VStack {
                ForEach(viewModel.records){record in
                    WeatherRecordView(record:record, viewModel:viewModel)
                }
            }.padding()
        }
    }
}

struct WeatherRecordView: View{
    var record: WeatherModel.WeatherRecord
    var viewModel: WeatherViewModel
    @State var param = 0
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: CGFloat(viewModel.cornerRadius)).stroke().frame(height:CGFloat(viewModel.height)) // wysokość komórek ustalona parametrem
            HStack{
                if(record.weather == "Clear"){
                    GeometryReader{ geometry in
                        Text("☀️").font(.system(size: CGFloat(viewModel.weatherSize)*geometry.size.height)).frame(alignment: .leading)
                    }// GeometryReader odpowiada za dostosowanie wielkości ikonki względem wysokości, a alignment: .leading wyrównuje do lewej strony
                }
                else if(record.weather == "LightCloud"){
                    GeometryReader{ geometry in
                        Text("⛅️").font(.system(size: CGFloat(viewModel.weatherSize)*geometry.size.height)).frame(alignment: .leading)
                    }
                }
                else if(record.weather == "HeavyCloud"){
                    GeometryReader{ geometry in
                        Text("☁️").font(.system(size: CGFloat(viewModel.weatherSize)*geometry.size.height)).frame(alignment: .leading)
                    }
                }
                else if(record.weather == "Showers"){
                    GeometryReader{ geometry in
                        Text("🌦").font(.system(size: CGFloat(viewModel.weatherSize)*geometry.size.height)).frame(alignment: .leading)
                    }
                }
                else if(record.weather == "Rain"){
                    GeometryReader{ geometry in
                        Text("🌧").font(.system(size: CGFloat(viewModel.weatherSize)*geometry.size.height)).frame(alignment: .leading)
                    }
                }
                else if(record.weather == "Thunderstorm"){
                    GeometryReader{ geometry in
                        Text("⛈").font(.system(size: CGFloat(viewModel.weatherSize)*geometry.size.height)).frame(alignment: .leading)
                    }
                }
                else if(record.weather == "Snow"){
                    GeometryReader{ geometry in
                        Text("🌨").font(.system(size: CGFloat(viewModel.weatherSize)*geometry.size.height)).frame(alignment: .leading)
                    }
                }
                VStack(alignment: .leading){ //nazwa miasta i parametr wyrównane względem siebie do lewej strony
                    Text(record.city)
                    if(param == 0){
                        Text("Temperature:\(record.temperature,specifier: "%.1f")ºC").font(.caption).onTapGesture {
                            param = 1
                        }
                    }
                    else if(param == 1){
                        Text("Humidity:\(record.humidity,specifier: "%.1f")hPa").font(.caption).onTapGesture {
                            param = 2
                        }
                    }
                    else if(param == 2){
                        Text("Wind:\(record.windSpeed,specifier: "%.1f")km/h \(Direction(windDir: record.windDir))").font(.caption).onTapGesture {
                            param = 0
                        }
                    }
                }.layoutPriority(viewModel.layoutPriority).frame(width: CGFloat(viewModel.cityWidth), alignment: .leading)//ta linijka na celu ma wyrównanie wszystkich komórek; layoutPriority sprawia, że VStack jest w naszej komórce najważniejszy, a width i alignment zapewniają, że po zmianie parametru VStack nie będzie się przesuwać, dzięki czemu komórki będą równe
                Text("🔄").font(.largeTitle).frame(alignment: .trailing).onTapGesture { //alignment: .trailing wyrównuje do prawej strony
                    viewModel.refresh(record:record)
                }
            }
        }
    }
}

func Direction(windDir: Float) -> String{
    if (windDir<22.5 || windDir>=337.5) {
        return "N"
    }
    else if (windDir>=22.5 && windDir<67.5){
        return "NE"
    }
    else if (windDir>=67.5 && windDir<112.5){
        return "E"
    }
    else if (windDir>=112.5 && windDir<157.5){
        return "SE"
    }
    else if (windDir>=157.5 && windDir<202.5){
        return "S"
    }
    else if (windDir>=202.5 && windDir<247.5){
        return "SW"
    }
    else if (windDir>=247.5 && windDir<292.5){
        return "W"
    }
    else if (windDir>=292.5 && windDir<337.5){
        return "NW"
    }
    return ""
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: WeatherViewModel())
    }
}
