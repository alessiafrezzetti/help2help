//
//  HoldButton.swift
//  try
//
//  Created by alessia frezzetti on 08/10/24.
//

import SwiftUI

struct HoldButton: View {
    var text : String
    var paddingHorizontal: CGFloat = 25
    var paddingVertical: CGFloat = 12
    var duration : CGFloat = 1
    var background : Color
    var loadingTint : Color
    var shape: AnyShape = .init(.capsule)
    var action : ()->()
    
    @State private var timer = Timer.publish(every: 0.01, on: .current, in: .common).autoconnect()
    @State private var timerCount: CGFloat = 0
    @State private var progress: CGFloat = 0
    @State private var isHolding: Bool = false
    @State private var isCompleted: Bool = false
    
    var body: some View {
        Text(text)
            .padding(.vertical, paddingVertical)
            .padding(.horizontal, paddingHorizontal)
            .background{
                GeometryReader {
                    let size = $0.size
                    
                   /* Circle()
                    .imageScale(.medium)
                    .shadow(radius: 10)
                    .foregroundStyle(.black)
                    .padding(60)
                    */
                    Rectangle()
                        .fill(background.gradient)
                    Rectangle()
                        .fill(loadingTint)
                        .frame(width: size.width * progress)
                }
            }
            .clipShape(shape)
            .contentShape(shape)
        //gestures
            .gesture(longPressGesture)
        //timer
            .onReceive(timer)
        {
            _ in
            if isHolding && progress != 1 {
                timerCount += 0.01
                progress = max (min(timerCount / duration, 1 ), 0)
                //this will convert the hold duration into a series of progress ranging from 0 to 1
            }
        }
            .onAppear(perform: cancelTimer)
    }
    var longPressGesture : some Gesture {
        LongPressGesture(minimumDuration: duration)
            .onChanged {
                isHolding = $0
                addTimer()
            }.onEnded { status in
           
            }
    }
    //adds timer
    func addTimer (){
        timer = Timer.publish(every: 0.01, on: .current, in: .common).autoconnect()
    }
    //cancel timer
    func cancelTimer()
    {
        timer.upstream.connect().cancel()
    }
}

#Preview {
    ContentView()
}



/*min 4:37 https:// www.youtube.com/watch?v=f5G1eNbuY9g */
