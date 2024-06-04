//
//  BindingView.swift
//  SwiftUITutorial
//
//  Created by Germán González on 12/6/23.
//

import SwiftUI

struct BindingView: View {
    @Binding var value:Int
    @ObservedObject var user:UserData
    @State private var selection:Int?
    
    var body: some View {
        VStack {
            Button("Suma 2") {
                value += 2
            }
            Button("Actualizar Datos") {
                user.name = "Bill Gates"
                user.age = 30
            }
            NavigationLink(destination: EnvironmentView(), tag: 1, selection: $selection) {
                Button("Ir a EnvironmentView") {
                    selection = 1
                }
            }
        }
    }
}

struct BindingView_Previews: PreviewProvider {
    static var previews: some View {
        BindingView(value: .constant(5), user: UserData())
    }
}
