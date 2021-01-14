//
//  ContentView.swift
//  decider
//
//  Created by Tristan Martinuson on 2020-08-10.
//  Copyright © 2020 Tristan Martinuson. All rights reserved.
//

import SwiftUI
import MapKit

var restaurant = ""
private var restaurants = [String]()

struct ContentView: View {
    //Old Variables for the initial randomizer
    @State private var selection = 0
    @State private var result = ""
    //@State var restaurant = "" //Something to do with this to store the landmarks name
    
    //New Variables for the application
    @State private var search = ""
    @State private var landmarks: [Landmark] = [Landmark]()
    @State private var tapped: Bool = false
    @ObservedObject var locationManager = LocationManager()
    
    private func getNearbyLandmarks() {
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = search
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            if let response = response {
                let mapItems = response.mapItems
                self.landmarks = mapItems.map {
                    Landmark(placemark: $0.placemark)
                }
            }
        }
    }
    
    func calculateOffset() -> CGFloat {
        if self.landmarks.count > 0 && !self.tapped {
            return UIScreen.main.bounds.size.height - UIScreen.main.bounds.size.width / 4
        } else if self.tapped {
            return 100
        } else {
            return UIScreen.main.bounds.size.height
        }
    }
    
    var body: some View {
        ZStack {
            
            MapView(landmarks: landmarks)
            
            VStack {
                Text("Enter in restaurants here:")
                    .font(.title)
                    .fontWeight(.ultraLight)
                    .padding(.top, 100.0)
                TextField("Search Restaurant Name", text: $search) {
                    // On commit
                    //self.addNewRestaurant()
                    self.getNearbyLandmarks()
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                
                Spacer(minLength: 50)
                Text(result)
                    .font(.title)
                    .fontWeight(.ultraLight)
                    .foregroundColor(Color.blue)
                
                Button(action: {
                    //Action here
                    self.result = restaurants.randomElement()!
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Corner Radius@*/20.0/*@END_MENU_TOKEN@*/)
                            .accentColor(/*@START_MENU_TOKEN@*/Color.blue/*@END_MENU_TOKEN@*/)
                        Text("Run")
                            .font(.headline)
                            .foregroundColor(Color.white)
                    }
                }
                .frame(width: 100.0, height: 50.0)
                
                List(restaurants, id: \.self) {
                    Text($0)
                }
                .padding(.top)
                .frame(height: 200.0)
            }
            
            PlaceListView(landmarks: landmarks) {
                self.tapped.toggle()
            }.animation(.spring())
                .offset(y: calculateOffset())
        }
    }
}

func addNewRestaurant() {
    //Fix this to add from the landmark that was pressed to the list of strings of options for randomization
    let answer = restaurant
    
    guard answer.count > 0 else { return }
    
    restaurants.insert(restaurant, at: 0)
    restaurant = ""
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
