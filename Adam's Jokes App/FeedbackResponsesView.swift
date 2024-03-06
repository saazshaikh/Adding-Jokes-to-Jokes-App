//
//  FeedbackResponsesView.swift
//  Adam's Jokes App
//
//  Created by Saaz Shaikh on 12/07/2023.
//

import SwiftUI

struct FeedbackResponsesView: View {
    
    var isFeedbackGood: Bool
    
    var body: some View {
        
        VStack{
            Image(isFeedbackGood ? "i am blushing please" : "brain to provide")
                .scaledToFit()
            Text (isFeedbackGood ? "stawp it wasnt THAT good! 🥹💅🏽" : "they say good humour needs a brain")
        }
    }
}

struct FeedbackResponsesView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackResponsesView(isFeedbackGood: true)
    }
}
