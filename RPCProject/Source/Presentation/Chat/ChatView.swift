//
//  ChatView.swift
//  RPCProject
//
//  Created by Beatriz Leonel da Silva on 02/04/24.
//

import SwiftUI

struct ChatView: View {
    @Binding var text: String
    @Binding var messages: [ChatMessage]
    @Namespace private var bottomID
    
    var action: (() -> Void)
    
    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    chat
                    Text("").id(bottomID)
                }
                .onAppear{
                    proxy.scrollTo(bottomID)
                }
                .onChange(of: messages) { (_, _) in
                    proxy.scrollTo(bottomID)
                }
            }
            .padding(8)
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
            
            HStack {
                TextField("Type here", text: $text)
                    .padding(.horizontal, 8)
                    .frame(height: 42)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.25) ,radius: 5)
                    .onSubmit {
                        action()
                        UIApplication.shared.endEditing()
                    }
                
                Button {
                    action()
                    UIApplication.shared.endEditing()
                } label: {
                    Image(systemName: "paperplane.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .symbolRenderingMode(.monochrome)
                        .foregroundColor(.blue)
                        .rotationEffect(.radians(0.8))
                }
                .frame(height: 42)
            }
            .padding(10)
        }
        .padding(.vertical, 8)
        .background(.white)
        .cornerRadius(30)
        .shadow(color: .black.opacity(0.25) ,radius: 5)
        
    }
    
    var chat: some View {
        VStack(spacing: 5) {
            ForEach(messages, id: \.self) { message in
                if let sender = ChatMessage.SenderType(rawValue: message.sender) {
                    switch sender {
                    case .localUser:
                        HStack {
                            Spacer(minLength: 50)
                            Text(message.content)
                                .foregroundColor(.black)
                                .padding(10)
                                .background(Color.green.opacity(0.5))
                                .cornerRadius(15)
                        }
                        .padding(.horizontal, 0)
                    case .remoteUser:
                        HStack {
                            Text(message.content)
                                .foregroundColor(.black)
                                .padding(10)
                                .background(Color.gray.opacity(0.5))
                                .cornerRadius(15)
                            Spacer(minLength: 50)
                        }
                        .padding(.horizontal, 5)
                    }
                }
            }
        }
    }
}

#Preview {
    ChatView(
        text: .constant(""),
        messages: .constant([
            .init(sender: .localUser, content: "Mensagem muitissimo longaaaaa longa longa longa longa longa longa longa longa longa"),
            .init(sender: .remoteUser, content: "Mensagem 2"),
            .init(sender: .localUser, content: "Mensagem muitissimo longaaaaa longa longa longa longa longa longa longa longa longa"),
            .init(sender: .localUser, content: "Mensagem muitissimo longaaaaa longa longa longa longa longa longa longa longa longa"),
            .init(sender: .localUser, content: "Mensagem muitissimo longaaaaa longa longa longa longa longa longa longa longa longa"),
            .init(sender: .localUser, content: "Mensagem muitissimo longaaaaa longa longa longa longa longa longa longa longa longa"),
            .init(sender: .localUser, content: "Mensagem muitissimo longaaaaa longa longa longa longa longa longa longa longa longa"),
            .init(sender: .localUser, content: "Mensagem muitissimo longaaaaa longa longa longa longa longa longa longa longa longa"),
            .init(sender: .localUser, content: "Mensagem muitissimo longaaaaa longa longa longa longa longa longa longa longa longa")
        ])) {
            print("Ação")
        }
}
