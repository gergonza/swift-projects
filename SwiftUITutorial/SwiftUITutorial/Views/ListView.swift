//
//  ListView.swift
//  SwiftUITutorial
//
//  Created by Germán González on 12/6/23.
//

import SwiftUI

final class ProgrammersModelData:ObservableObject {
    
    @Published
    var programmers = [
        Programmer(id: 0, name: "Brais Moure", languages: "Swift, Kotlin", avatar: Image(systemName: "person"), favorite: true),
        Programmer(id: 1, name: "Ana", languages: "Java, Kotlin", avatar: Image(systemName: "person.fill"), favorite: false),
        Programmer(id: 2, name: "Pablo", languages: "C++, C#", avatar: Image(systemName: "person.fill"), favorite: false),
        Programmer(id: 3, name: "Sara", languages: "JavaScript", avatar: Image(systemName: "person.fill"), favorite: true),
        Programmer(id: 4, name: "Carlos", languages: "Go, Python", avatar: Image(systemName: "person.fill"), favorite: false)
    ]
}

struct ListView: View {
    
    @EnvironmentObject var programmersModelData:ProgrammersModelData
    
    @State private var showFavorites = false
    
    private var filteredProgrammers:[Programmer] {
        return programmersModelData.programmers.filter {
            programmer in
            return !showFavorites || programmer.favorite
        }
    }
    
    var body: some View {
        NavigationView {
        
            VStack {
            
                Toggle(isOn: $showFavorites) {
                    Text("Mostrar Favoritos")
                }.padding()
            
            
                List(filteredProgrammers, id: \.id) {
                    programmer in
                    NavigationLink(destination: ListDetailView(favorite: $programmersModelData.programmers[programmer.id].favorite, programmer: programmer)) {
                        RowView(programmer: programmer)
                    }
                }
                
            }.navigationTitle("Programmers")
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView().environmentObject(ProgrammersModelData())
    }
}
