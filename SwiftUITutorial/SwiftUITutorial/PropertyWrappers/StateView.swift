//
//  StateView.swift
//  SwiftUITutorial
//
//  Created by Germán González on 12/6/23.
//

import SwiftUI

class UserData:ObservableObject {
    
    @Published var name = "Brais Moure"
    @Published var age = 34
}

struct StateView: View {
    
    @State private var value = 0
    @State private var selection:Int?
    @StateObject private var user = UserData()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("El valor actual es \(value)")
                Button("Suma 1") {
                    value += 1
                }
                Text("Mi nombre es \(user.name) y mi edad es \(user.age)")
                Button("Actualizar Datos") {
                    user.name = "Germán González"
                    user.age = 35
                }
                NavigationLink(destination: BindingView(value: $value, user: user), tag: 1, selection: $selection) {
                    Button("Ir a BindingView") {
                        selection = 1
                    }
                }
            }.navigationTitle("StateView")
        }
    }
}

struct StateView_Previews: PreviewProvider {
    static var previews: some View {
        StateView().environmentObject(UserData())
    }
}
