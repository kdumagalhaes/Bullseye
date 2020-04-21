//
//  AboutView.swift
//  Bullseye
//
//  Created by Carlos Eduardo Magalhães Pereira on 4/18/20.
//  Copyright © 2020 Carlos Eduardo Magalhães Pereira. All rights reserved.
//

import SwiftUI

struct AboutView: View {
  
  let beige = Color(red: 255.0 / 255.0, green: 214.0 / 255.0, blue: 179.0 / 255.0)
  
  struct AboutHeadingStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .foregroundColor(Color.black)
        .font(Font.custom("Arial Rounded MT Bold", size: 30))
        .padding(.top, 20)
        .padding(.bottom, 20)
    }
  }
  
  struct AboutBodyStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .foregroundColor(Color.black)
        .font(Font.custom("Arial Rounded MT Bold", size: 16))
        .padding(.leading, 60)
        .padding(.trailing, 60)
        .padding(.bottom, 20)
    }
  }
  
  var body: some View {
    Group {
      VStack {
        Text("🎯 Bull's eye 🎯").modifier(AboutHeadingStyle())
        Text("Este joguinho é fruto do meu primeiro contato com desenvolvimento iOS, mais especificamente SwiftUI, através dos ensinamentos do Ray Wenderlich.").modifier(AboutBodyStyle())
        Text("Espero que goste!").modifier(AboutBodyStyle())
      }
      .navigationBarTitle("Sobre Bull's eye")
      .background(Color.white)
    }
    .background(Image("Redbg"))
  }
}

struct AboutView_Previews: PreviewProvider {
  static var previews: some View {
    AboutView().previewLayout(.fixed(width: 896, height: 414))
  }
}
