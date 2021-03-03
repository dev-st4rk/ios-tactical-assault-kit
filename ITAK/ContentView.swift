//
//  ContentView.swift
//  ITAK
//
//  Created by Henrique Gonçalves Lourenço Silva on 02/03/21.
//

import SwiftUI
import MapKit
import CoreLocation

struct ContentView: View {
    var body: some View {
        TabView{
            Text("Home")
                .tabItem{
                    Image(systemName: "house")
                    Text("Home")
                }

            Chat()
                .tabItem{
                    Image(systemName: "message")
                    Text("Chat")
                }

            Home()//Location
                .tabItem{
                    Image(systemName: "map")
                    Text("Location")
                }
            
            Tools()
                .tabItem{
                    Image(systemName: "bonjour")
                    Text("Tools")
                }
            
            SettingsView()
                .tabItem{
                    Image(systemName: "gear")
                    Text("Settings")
                }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

