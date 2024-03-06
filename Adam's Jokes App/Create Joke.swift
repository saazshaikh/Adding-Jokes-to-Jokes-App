//
//  Create Joke.swift
//  Adam's Jokes App
//
//  Created by Saaz Shaikh on 08/01/2024.
//

import SwiftUI
struct Create_Joke: View {
    
    @State private var newStarter = ""
    @State private var newPunchline = ""
    
    @Binding var jokesSet: [Joke]
    
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        
        Form{
            
            Section ("info") {
                TextField("Starter", text: $newStarter)
                TextField("Punchline", text: $newPunchline)
            }
            
            Section ("action") {

                Button("Save") {
                    if !newStarter.isEmpty{
                        if !newPunchline.isEmpty{
                            let newJoke = Joke(setup: newStarter, punchline: newPunchline)
                            jokesSet.append(newJoke)
                            dismiss()
                            print("Joke Added")
                        }
                    }
                }
               Button("Cancel", role: .destructive) {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    Create_Joke(jokesSet: .constant([]))
}
