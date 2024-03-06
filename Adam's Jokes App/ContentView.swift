//
//  ContentView.swift
//  Adam's Jokes App
//
//  Created by Saaz Shaikh on 10/07/2023.
//

import SwiftUI
import Foundation

struct ContentView: View {
    
   @State private var jokes = [
                 Joke(setup: "Why couldn't the bicycle stand up?",
                      punchline: "It was two tired!"),
                 Joke(setup: "Why did the chicken cross the road?",
                      punchline: "To get to the other side!"),
                 Joke(setup: "Is this pool safe for diving?",
                      punchline: "It deep ends"),
                 Joke(setup: "Did you hear about the cheese factory that exploded in France?",
                      punchline: "There was nothing left but de Brie"),
                 Joke(setup: "Dad, can you put my shoes on?",
                      punchline: "I don’t think they'll fit me")
   ]
    
    
    @State private var showPunchline = false
    @State private var currentJokeIndex = 0
    @State private var isFeedbackPresented = false
    @State private var displaySheet = false
    @State private var isFeedbackPositive = true
    
    @State private var punchlineSize = 0.1
    //punchline size is 10% of the original size
    @State private var rotationOfPunchline = Angle.zero
    @State private var punchlineOpacity = 0.0
    @State private var tapToContinueOffset = 100.0
    @State private var isButtonClicked = true
    @State private var showCreateJoke = false
    var createJoke = Create_Joke(jokesSet: .constant([]))
    
    var body: some View {
            ZStack {
                Color(.systemBackground)
                    .alert ("Did you like the last joke?", isPresented: $isFeedbackPresented) {
                        Button ("😍") {
                            print ("good")
                            displaySheet = true
                            isFeedbackPositive = true
                        }
                        Button ("🤮") {
                            print ("you are a terrible person")
                            displaySheet = true
                            isFeedbackPositive = false
                        }
                    }
                    .sheet(isPresented: $displaySheet){
                        FeedbackResponsesView(isFeedbackGood: isFeedbackPositive)
                            .onAppear() {
                                isButtonClicked = true
                            }
                    }
                
                NavigationView {
                    VStack{
                        Text (jokes [currentJokeIndex % jokes.count].setup)
                            .padding()
                        

                            withAnimation (.interpolatingSpring(stiffness: 100, damping: 7)) {
                                Button {
                                    print ("joke said")
                                    withAnimation {
                                        showPunchline = true
                                        isButtonClicked = false
                                    }
                                    currentJokeIndex += 1
                                }label: {
                                    Text("The Punchline")
                                        .padding()
                                        .background(.red)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                            }

                        

                            withAnimation (.interpolatingSpring(stiffness: 100, damping: 7)) {
                                Button {
                                    print ("create joke")
                                    withAnimation {
                                        showCreateJoke = true
                                        isButtonClicked = false
                                    }
                                    currentJokeIndex += 1
                                }label: {
                                    Text("Add Joke")
                                        .padding()
                                        .foregroundColor(.red)
                                        .bold()
                                        .cornerRadius(10)
                                }
                            }

                        
                        NavigationLink(destination: Create_Joke(jokesSet: $jokes), isActive: $showCreateJoke) {
                            EmptyView()
                        }
                        
                        if showPunchline {
                            Text(jokes [currentJokeIndex  % jokes.count].punchline)
                            // the % jokes.count makes the counter less than 5 at all times, so that the app doesn't crash
                                .padding()
                                .opacity(showPunchline ? 1: 0)
                            // the .opacity basially means that if the condition is true then the text will become visible, otherwise it will remin transparent
                                .scaleEffect(punchlineSize)
                            //this would make the punchline enlarge by the punchlineSize
                                .rotationEffect(rotationOfPunchline)
                                .opacity(punchlineOpacity)
                                .onAppear {
                                    withAnimation (.interpolatingSpring(stiffness: 100, damping: 7)) {
                                        punchlineSize = 1
                                        rotationOfPunchline = Angle(degrees: 360)
                                        punchlineOpacity = 1
                                        tapToContinueOffset = 0
                                    }
                                }.onDisappear {
                                    punchlineSize = 0.1
                                    rotationOfPunchline = .zero
                                    // the .zero can be written instead of Angle.zero, this is because at this point swwift knows htat .zero imples that its Angle.zero, this is because we used the Angle.zero for the same variable earlier
                                    punchlineOpacity = 0
                                    tapToContinueOffset = 100
                                }
                            // this makes the punchline size 1 (100% of its original size) when it appears and then 0.1 (10% of its orginial size) when it disappears
                            
                            
                            Text("Tap **anywhere** to continue")
                                .padding()
                                .italic()
                                .opacity (punchlineOpacity)
                                .offset(y: tapToContinueOffset)
                        }
                        
                        
                        
                    }
                }
            }
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView().preferredColorScheme (.dark)
    
    }
}
