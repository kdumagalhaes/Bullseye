//
//  ContentView.swift
//  Bullseye
//
//  Created by Carlos Eduardo Magalhães Pereira on 4/18/20.
//  Copyright © 2020 Carlos Eduardo Magalhães Pereira. All rights reserved.
//

import SwiftUI

struct ContentView: View {

  @State var alertIsVisible = false
  @State var sliderValue = 50.0
  @State var target = Int.random(in: 1...100)
  @State var score = 0
  @State var round = 1
  
  struct LabelStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .foregroundColor(Color.white)
        .modifier(Shadow())
        .font(Font.custom("Arial Rounded MT Bold", size: 18))
    }
  }
 
  struct ValueStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .foregroundColor(Color.yellow)
        .modifier(Shadow())
        .font(Font.custom("Arial Rounded MT Bold", size: 24))
    }
  }
  
  struct ButtonLargeTextStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .foregroundColor(Color.black)
        .font(Font.custom("Arial Rounded MT Bold", size: 18))
    }
  }

  struct ButtonSmallTextStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .foregroundColor(Color.black)
        .font(Font.custom("Arial Rounded MT Bold", size: 15))
    }
  }
  
  struct Shadow: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .shadow(color: Color.black, radius: 2, x: 2, y: 2)

    }
  }
 
  struct ButtonBg: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .padding()
            .frame(height: 50)
            .background(Color.yellow)
            .cornerRadius(5)
            .shadow(color: Color.black, radius: 2, x: 2, y: 2)
    }
    }
    
  var body: some View {
    VStack {
      Spacer()
      
      // Target row
      HStack {
        Text("Posicione o círculo o mais próximo possível de:").modifier(LabelStyle())
        Text("\(target)").modifier(ValueStyle())
      }
      Spacer()
      
      // Slider row
      HStack {
        Text("1").modifier(LabelStyle())
        Slider(value: $sliderValue, in: 1...100).accentColor(Color.yellow)
        Text("100").modifier(LabelStyle())
      }
      Spacer()
      
      // Button row
      Button(action: {
        self.alertIsVisible = true
        
      }) {
        Text("Vamos lá!").modifier(ButtonLargeTextStyle())
      }
      .alert(isPresented: $alertIsVisible) { () -> Alert in
        //let roundedValue = Int(sliderValue.rounded())
        return Alert(title: Text(alertTitle()), message: Text(
          "O valor foi \(sliderValueRounded()).\n" +
          "Você fez \(pointsForCurrentRound()) pontos nesta rodada."
        ), dismissButton: .default(Text("Mais uma vez!")) {
          self.score = self.score + self.pointsForCurrentRound()
          self.target = Int.random(in: 1...100)
          self.round = self.round + 1
        })
      }
      .modifier(ButtonBg())
      Spacer()
      
      // Score row
      HStack {
        Button(action: {
          self.startNewGame()
        }) {
          HStack {
            Image(systemName:"arrow.clockwise.circle")
                .foregroundColor(Color.black)
            Text("Recomeçar").modifier(ButtonSmallTextStyle())
          }
        }
        .modifier(ButtonBg())
        Spacer()
        Text("Pontos:").modifier(LabelStyle())
        Text("\(score)").modifier(ValueStyle())
        Spacer()
        Text("Rodada:").modifier(LabelStyle())
        Text("\(round)").modifier(ValueStyle())
        Spacer()
        NavigationLink(destination: AboutView()) {
          HStack {
            Image(systemName:"info.circle")
                .foregroundColor(Color.black)
            Text("Info").modifier(ButtonSmallTextStyle())
          }
        }
        .modifier(ButtonBg())
      }
      .padding(.bottom, 20)
    }
    .background(Image("Redbg"), alignment: .center)
    .accentColor(Color.white)
    .navigationBarTitle("Bull's Eye")
  }
  
  func sliderValueRounded() -> Int {
    Int(sliderValue.rounded())
  }
  
  func amountOff() -> Int {
    abs(target - sliderValueRounded())
  }
  
  func pointsForCurrentRound() -> Int {
    let maximumScore = 100
    let difference = amountOff()
    let bonus: Int
    if difference == 0 {
      bonus = 100
    } else if difference == 1 {
      bonus = 50
    } else {
      bonus = 0
    }
    return maximumScore - difference + bonus
  }
  
  func alertTitle() -> String {
    let difference = amountOff()
    let title: String
    if difference == 0 {
      title = "Perfeito!"
    } else if difference < 5 {
      title = "Quase lá!"
    } else if difference <= 10 {
      title = "Mais ou menos."
    } else {
      title = "Foi longe, hein!"
    }
    return title
  }
  
  func startNewGame() {
    score = 0
    round = 1
    sliderValue = 50.0
    target = Int.random(in: 1...100)
  }
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().previewLayout(.fixed(width: 896, height: 414))
  }
}
