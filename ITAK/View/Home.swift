//
//  Home.swift
//  ITAK
//
//  Created by Henrique Gonçalves Lourenço Silva on 02/03/21.
//

import SwiftUI
import MapKit
import CoreLocation

struct Home: View {
    @StateObject var mapData = MapViewModel()
    
    //Location Manager
    @State var locationManager = CLLocationManager()
    
    var body: some View {
        ZStack{
            MapView()
                //using it as enviroment object so that it can be used ints subviews
                .environmentObject(mapData)
                .ignoresSafeArea(.all, edges: .all)
            
            VStack{
                
                VStack(spacing: 0){
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Search", text: $mapData.searchTxt)
                            .colorScheme(.light)
                    }
                    .padding(.vertical,10)
                    .padding(.horizontal)
                    .background(Color.white)
                    
                    //Displaying Results
                    
                    if !mapData.places.isEmpty && mapData.searchTxt != "" {
                        
                        ScrollView{
                            
                            VStack(spacing: 15){
                                
                                ForEach(mapData.places){place in
                                    Text(place.place.name ?? "")
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading)
                                        .onTapGesture{
                                            mapData.selectPlace(place: place)
                                        }
                                    
                                    Divider()
                                }
                                
                            }
                            .padding(.top)
                        }
                        .background(Color.white)
                        
                    }
                    
                }
                .padding()
                

                Spacer()
                
                VStack{
                    
                    Button(action: mapData.focusLocation, label: {
                        Image(systemName: "target")
                            .font(.title2)
                            .padding(10)
                            .background(Color.black)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                    })
                    
                    
                    Button(action: mapData.updateMapType, label: {
                        Image(systemName: mapData.mapType == .standard ? "network" : "map")
                            .font(.title2)
                            .padding(10)
                            .background(Color.black)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                    })
                    
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
                
            }
        }
        .onAppear(perform: {
            //Setting Delegate
            
            locationManager.delegate = mapData
            locationManager.requestWhenInUseAuthorization()
            
        })
        //Permission Denied alert
        .alert(isPresented: $mapData.permissionDenied, content: {
            Alert(title: Text("Permission Denied"), message: Text("Please Enable Permission in App Settings"),
                  dismissButton: .default(Text("Goto Settings"),
                  action:{
                        //Redirecting User to Settings
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                  }))
        })
        .preferredColorScheme(.dark)
        .onChange(of: mapData.searchTxt, perform: { value in
            
            //Searching Places
            
            //You can use your own delay time to contiuous search request
            
            let delay = 0.3
            
            DispatchQueue.main.asyncAfter(deadline: .now() + delay)
            {
                if value == mapData.searchTxt{
                    //Search...
                    self.mapData.searchQuery()
                }
            }
        })
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
