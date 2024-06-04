//
//  ImageView.swift
//  SwiftUITutorial
//
//  Created by Germán González on 12/6/23.
//

import SwiftUI

struct ImageView: View {
    var body: some View {
        VStack {
            Image("Swift")
                .resizable()
                .padding(50)
                .frame(width: 300, height: 300)
                .background(Color.gray)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.blue, lineWidth: 4))
                .shadow(color: Color.gray, radius: 5)
            
            Image(systemName: "person.fill.badge.minus")
                .resizable()
                .padding(50)
                .frame(width: 300, height: 300)
                .background(Color.gray)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.blue, lineWidth: 4))
                .shadow(color: Color.gray, radius: 5)
                .foregroundColor(Color.blue)
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
    }
}
