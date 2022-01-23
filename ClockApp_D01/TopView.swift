//
//  TopView.swift
//  ClockApp_D01
//
//  Created by Harsh Yadav on 18/08/21.
//

import SwiftUI

struct TopView: View {
    @Binding var mode:Bool
    @State var Colorschme = ColorScheme.light
    var body: some View {
            HStack {
                    
                    Text("Clock App")
                        .font(.system(size: 25))
                        .fontWeight(.medium)
                        .padding()
                        Spacer()
                
                
                Button(action: {
                    mode.toggle()
                    print("\(mode)")
                    if mode {
                        Colorschme = .dark
                    }
                    else{
                        Colorschme = .light
                    }
                        
                }, label: {
                    Image(systemName: mode ?  "moon.fill" : "sun.max.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color.theme.clockIcon)
                        .padding()
                })
            }
        }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopView(mode: .constant(false))
            .previewLayout(.sizeThatFits)
           
    }
}
