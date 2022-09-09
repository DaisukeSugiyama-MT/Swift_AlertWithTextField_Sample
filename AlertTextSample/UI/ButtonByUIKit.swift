import SwiftUI

struct AlertControllerWithTextFieldContainer: UIViewControllerRepresentable {
    
    @Binding var textFieldText: String
    @Binding var isPresented: Bool
    
    let title: String?
    let message: String?
    let placeholderText: String?
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return UIViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        let alert = UIAlertController(title:title,message: message,preferredStyle:.alert)
        
        // TextFieldの追加
        alert.addTextField{ textField in
            textField.placeholder = placeholderText
            textField.returnKeyType = .done
        }
        
        // 決定ボタンアクション
        let doneAction = UIAlertAction(title:"決定",style:.default){ _ in
            if let textField = alert.textFields?.first,
               let text = textField.text{
                textFieldText = text
            }
        }
        
        // キャンセルボタンアクション
        let cancelAction = UIAlertAction(title:"キャンセル",style:.cancel)
        
        
        alert.addAction(cancelAction)
        alert.addAction(doneAction)
        
        DispatchQueue.main.async{
            uiViewController.present(alert,animated: true){
                isPresented = false
            }
        }
    }
}

// 上のやつをSwiftUIぽく使うためのView
struct AlertWithTextField:ViewModifier{
    @Binding var textFieldText: String
    @Binding var isPresented: Bool
    
    let title: String?
    let message: String?
    let placeholderText: String
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if isPresented {
                AlertControllerWithTextFieldContainer(
                    textFieldText: $textFieldText,
                    isPresented: $isPresented,
                    title: title,
                    message: message,
                    placeholderText: placeholderText
                )
            }
        }
    }
}


// Viewに対して機能拡張する ここではViewからalertWithTextFieldが使えるようにする
extension View {
    func alertWithTextField(_ text: Binding<String>,isPresented:Binding<Bool>,title:String?,message:String?,placeholderText:String)-> some View{
        self.modifier(AlertWithTextField(
            textFieldText: text,
            isPresented: isPresented,
            title: title,
            message: message,
            placeholderText: placeholderText
        ))
    }
}
