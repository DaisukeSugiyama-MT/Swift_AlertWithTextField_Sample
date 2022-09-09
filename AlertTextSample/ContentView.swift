//
//  ContentView.swift
//  AlertTextSample
//

import SwiftUI

struct ContentView: View {
    @State private var isShowAlert = false
    @State private var text = ""
    var body: some View {
        VStack(spacing:75){
            // iOS16の方の書き方 とても楽
            ButtonWithAlert()
            // UIKitで作成したAlertを呼び出す
            Button("UIKitでのButton"){
                self.isShowAlert = true
            }
            
        }.alertWithTextField(
            $text,
            isPresented: $isShowAlert,
            title: "UIKitのAlert",
            message: "message",
            placeholderText: "placeholder")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
