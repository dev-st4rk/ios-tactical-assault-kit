//
//  SettingsView.swift
//  ITAK
//
//  Created by Henrique Gonçalves Lourenço Silva on 03/03/21.
//

import SwiftUI

struct SettingsView: View {
    @State var username: String = ""
    @State private var isPrivate: Bool = true
    @State private var notificationsEnable:Bool = false
    @State private var previewIndex = 0
    
    var previewOptions = ["Always", "When Unlocked", "Never"]

    var body: some View {
        NavigationView{
            
            Form{
                Section{
                    HStack{
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                        VStack(alignment: .leading){
                            Button("Sign in to your Account"){}
                            .font(.callout)
                        }
                    }
                }
                
                Section{
                    HStack{
                        Image(systemName: "gear")
                            .frame(width: 25, height: 25)
                            .foregroundColor(.white)
                            .background(Color.gray)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                        
                        Picker(selection:$previewIndex, label: Text("General")){
                            
                        }
                    }
                    
                    HStack{
                        Image(systemName: "person.crop.circle.badge.exclam")
                            .frame(width: 25, height: 25)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                        
                        Picker(selection:$previewIndex, label: Text("Accessibility")){
                            
                        }
                    }
                    
                    HStack{
                        Image(systemName: "hand.raised.fill")
                            .frame(width: 25, height: 25)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                        
                        Picker(selection:$previewIndex, label: Text("Privacy")){
                            
                        }
                    }
                    
                    
                }
                
                Section{
                    HStack{
                        Image(systemName: "key.fill")
                            .frame(width: 25, height: 25)
                            .foregroundColor(.white)
                            .background(Color.gray)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                        
                        Picker(selection:$previewIndex, label: Text("Passwords")){
                    }
                }
                
                
            }
//===================================================================
                Section(header:Text("PROFILE")){
                    
                    TextField("Username", text:$username)
                    Toggle(isOn: $isPrivate, label: {
                        Text("Private Account")
                    })
                    
                }
//===================================================================
                Section(header:Text("NOTIFICATIONS")){
                    
                    Toggle(isOn: $notificationsEnable, label: {
                        Text("Enable")
                    })
                    Picker(selection: $previewIndex, label:Text("Show Previews")){
                        
                        ForEach(0..<previewOptions.count){
                            Text(self.previewOptions[$0])
                        }
                    }
                }
//===================================================================
                Section(header:Text("ABOUT")){
                    HStack{
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                    }
                }
//===================================================================
                Section{
                    Button(action: {
                        print("Button clicked")
                    }, label: {
                        Text("Reset All Settings")
                    })
                }
                
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingsView()
                .preferredColorScheme(.dark)
            SettingsView()
        }
    }
}
