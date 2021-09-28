//
//  ContentView.swift
//  scrollviewReader_tutorial
//
//  Created by Jeff Jeong on 2021/09/29.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedIndex: Int = 0
    
    @Namespace var topID
    
    @Namespace var bottomID
    
    var selectedBG : (Int, Int) -> Color = { currentItemIndex, selectedItemIndex in
        if currentItemIndex == selectedItemIndex {
            return Color.green
        } else {
            return Color.yellow
        }
    }
    
    var body: some View {
        
        
        VStack{
            ScrollViewReader{ proxy in
                ScrollView(.vertical, showsIndicators: false){
                    
                    Button("Scroll to Bottom") {
                        withAnimation {
                            proxy.scrollTo(bottomID)
                        }
                    }
                    .id(topID)
                    
                    ForEach(0..<100, content: { index in
                        Text("오늘도 빡코딩! 🔥👨‍💻 \(index)")
                            .padding(50)
                            .background(selectedBG(index, selectedIndex))
                            .id(index)
                    })
                    .onChange(of: selectedIndex, perform: { changedIndex in
                        print("changedIndex: ", changedIndex)
                        withAnimation{
                            proxy.scrollTo(changedIndex, anchor: .center)
                        }
                    })
                    
                    Button("Scroll to Top") {
                        withAnimation {
                            proxy.scrollTo(topID)
                        }
                    }
                    .id(bottomID)
                }
            }
            
            HStack(spacing: 10) {
                Button(action: {
                    selectedIndex = 6
                }, label: {
                    Text("인덱스 : 6").padding()
                })
                Button(action: {
                    selectedIndex = 50
                }, label: {
                    Text("인덱스 : 50").padding()
                })
                Button(action: {
                    selectedIndex = 90
                }, label: {
                    Text("인덱스 : 90").padding()
                })
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
