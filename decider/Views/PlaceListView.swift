//
//  PlaceListView.swift
//  decider
//
//  Created by Tristan Martinuson on 2020-09-01.
//  Copyright © 2020 Tristan Martinuson. All rights reserved.
//

import SwiftUI
import MapKit

struct PlaceListView: View {
    
    let landmarks: [Landmark]
    var onTap: () -> ()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                EmptyView()
            }.frame(width: UIScreen.main.bounds.size.width, height: 60)
                .background(Color.gray)
            .gesture(TapGesture()
                .onEnded(self.onTap))
            
            List {
                ForEach(self.landmarks, id: \.id) { landmark in
                    
                    HStack {
                        
                        VStack(alignment: .leading) {
                            Text(landmark.name)
                                .fontWeight(.bold)
                            Text(landmark.title)
                        }
                        Spacer()
                        Button(action: {
                            restaurant = landmark.name
                            addNewRestaurant()
                        }) {
                            Image(systemName: "plus")
                                .foregroundColor(Color.blue)
                        }
                    }
                }
            }.animation(nil)
        }.cornerRadius(10)
    }
}

struct PlaceListView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceListView(landmarks: [Landmark(placemark: MKPlacemark())], onTap: {})
    }
}
