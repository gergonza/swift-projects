//
//  MainView.swift
//  SwiftUITutorial
//
//  Created by Germán González on 12/6/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        ScrollView {
            VStack {
                MapView()
                    .frame(height: 400)
                
                ImageView()
                    .offset(y: -150)
                
                Divider()
                    .padding()
                
                ContentView()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
        MainView()
            .preferredColorScheme(.dark)
            .previewDevice("iPad Pro (12.9-inch) (6th generation)")
    }
}
