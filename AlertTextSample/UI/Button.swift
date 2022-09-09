import SwiftUI

struct ButtonWithAlert: View {
    @State private var isShowAlert = false
    @State private var userName = ""
    var body: some View {
        Button("show Alert"){
            self.isShowAlert = true
        }
        .alert("AlertTitle",isPresented: $isShowAlert,actions:{
            TextField("UserName",text:$userName)
            SecureField("Password",text:$userName)

            Button("OK!",action:{})
            Button("キャンセル!",role:.cancel,action:{})
        },message:{
          Text("メッセージが表示されます")
        })
    }
}
