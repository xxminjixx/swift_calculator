//
//  ContentView.swift
//  test0723
//
//  Created by 최민지 on 2022/07/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowing = false
    var body: some View {
        Button("Alert 띄우기"){
            isShowing = true
        }
        .alert("메시지", isPresented: $isShowing){
            Button("OK", role: .cancel) {}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
