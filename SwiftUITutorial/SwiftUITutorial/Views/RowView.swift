//
//  RowView.swift
//  SwiftUITutorial
//
//  Created by Germán González on 12/6/23.
//

import SwiftUI

struct RowView: View {
    
    var programmer:Programmer
    
    var body: some View {
        HStack {
            programmer.avatar
                .resizable()
                .frame(width: 40, height: 40)
                .padding()
            
            VStack {
                Text(programmer.name)
                    .font(.title)
                Text(programmer.languages)
                    .font(.title)
            }
            
            Spacer()
            
            if programmer.favorite{
                Image(systemName: "star.fill")
                    .foregroundColor(Color.yellow)
            }
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(programmer: Programmer(id: 1, name: "Brais Moure", languages: "Swift, Kotlin", avatar: Image(systemName: "person.fill"), favorite: true))
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
