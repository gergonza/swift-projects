//
//  ContentView.swift
//  SwiftUITutorial
//
//  Created by Germán González on 12/6/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20.0) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Bienvenidos al curso de SwiftUI!")
                .font(.title)
                .foregroundColor(Color.blue)
                .padding()
                .background(Color.gray)
            
            Spacer()
            
            ZStack {
                Text("").frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.gray)
                    .padding()
                
                Text("").frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.green)
                    .padding(40)
                
                Text("").frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.red)
                    .padding(60)
                
                Text("").frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.blue)
                    .padding(80)
            }
            
            HStack {
                Text("Hola, hackermen!")
                    .padding()
                    .background(Color.gray)
                
                Spacer()
                
                Text("Bienvenidos a MoureDev!")
                    .padding()
                    .background(Color.gray)
            }
            
            VStack {
                Text("6")
                Text("7")
                Text("8")
                Text("9")
                Text("10")
                Text("11")
                Text("12")
                Text("13")
                Text("14")
                
                VStack {
                    Text("15")
                    Text("16")
                    Text("17")
                }
            }
        }
        .background(Color.yellow)
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
