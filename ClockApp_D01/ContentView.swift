//
//  ContentView.swift
//  ClockApp_D01
//
//  Created by Harsh Yadav on 18/08/21.
//

import SwiftUI

struct ContentView: View {
    @State var mode:Bool = false
    var width = UIScreen.main.bounds.width
    var height = UIScreen.main.bounds.height

    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            ZStack {
                VStack {
                    
                    TopView(mode: $mode)
                    ClockView(mode: $mode)
                    Spacer()
                    
                }
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        
    }
}



struct ClockView: View {
    
    
    var width = UIScreen.main.bounds.width
    var height = UIScreen.main.bounds.height
    @Binding var mode:Bool
    @State var currentTime = Time(min: 0, sec: 0, hour: 0)
    @State var reciever = Timer.publish(every: 1, on: .current, in: .default).autoconnect()
    
    
    var body: some View {
        ZStack {
            
            BottomStipVew()
            ZStack{
                
                
                //upper shadow of strip
                Rectangle()
                    .frame(width: 150, height: 300)
                    .cornerRadius(15)
                    .offset(x: 10, y: -50)
                    .foregroundColor(Color(#colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)))
                //upper strip bg
                Rectangle()
                    .frame(width: 150, height: 300)
                    .cornerRadius(10)
                    .offset(x: 0, y: -50)
                    .foregroundColor(Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)))
                //upper strip fg
                VStack {
                    ForEach(0..<5){ i in
                        Rectangle()
                            .frame(width: 150, height: 30, alignment: .center)
                            .offset(x: 0, y: -90)
                            .foregroundColor(Color(#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)))
                    }
                }
            }
            
            
            //Dial shadow
            Circle()
                .foregroundColor(Color(#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1))).opacity(0.5)
                .frame(width: width-25, height: width)
                .offset(x: 3.5, y: 0)
            //Dialx
            Circle()
                .foregroundColor(Color.theme.clockDial).opacity(1)
                .frame(width: width-29, height: width)
            
           
            
            
            //
            ForEach(0..<60) { i in
                Rectangle()
                    .foregroundColor(Color.theme.clock)
                    .frame(width: 2, height: i%5 == 0 ? 15: 7)
                    .offset(x: 0, y: (width - 60)/2)
                    .rotationEffect(.init(degrees: Double(i)*6))
            }
            
            
            //second hand
            Rectangle()
                .foregroundColor(Color.theme.clock)
                .frame(width: 2, height: 100)
                .offset(x: 0, y: -(width-220)/2)
                .rotationEffect(.init(degrees: Double(currentTime.sec)*6))

            //hour hand
            Rectangle()
                .frame(width: 4, height: 50)
                .foregroundColor(Color.theme.clock)
                .offset(x: 0, y: -(width-272)/2)
                .rotationEffect(.init(degrees: Double(currentTime.hour)*30))
            
            //min hand
            Rectangle()
                .foregroundColor(Color.theme.clock)
                .frame(width: 3, height: 70)
                .offset(x: 0, y: -(width-250)/2)
                .rotationEffect(.init(degrees: Double(currentTime.min)*6))
            
            //Center
            Circle()
                .frame(width: 15, height: 15, alignment: .center)
                .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                .opacity(1)
            
                   
        }
        .onAppear(){
            let calender = Calendar.current
            let min = calender.component(.minute, from: Date())
            let sec = calender.component(.second, from: Date())
            let hour = calender.component(.hour, from: Date())
            
            withAnimation(Animation.linear(duration: 0.01)){
                self.currentTime = Time(min: min, sec: sec, hour: hour)
            }
        }
        
        .onReceive(reciever) { (_) in
            let calender = Calendar.current
            let min = calender.component(.minute, from: Date())
            let sec = calender.component(.second, from: Date())
            let hour = calender.component(.hour, from: Date())
            
            withAnimation(Animation.linear(duration: 0.01)){
                self.currentTime = Time(min: min, sec: sec, hour: hour)
            }
        }
    }
}


//view Model
struct Time {
    var min:Int
    var sec:Int
    var hour:Int
}

//bottom watch strip view
struct BottomStipVew: View {
    var body: some View {
        ZStack{
            //shadow of strip
            Rectangle()
                .frame(width: 150, height: 300)
                .offset(x: 10, y: 250)
                .foregroundColor(Color(#colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)))
            //strip bg
            Rectangle()
                .frame(width: 150, height: 300)
                .offset(x: 0, y: 270)
                .foregroundColor(Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)))
            //strip fg
            VStack {
                ForEach(0..<5){ i in
                    Rectangle()
                        .frame(width: 150, height: 30, alignment: .center)
                        .offset(x: 0, y: 210)
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)))
                }
            }
        }
    }
}
