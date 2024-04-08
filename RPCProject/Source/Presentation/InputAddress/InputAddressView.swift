//
//  InputAddressView.swift
//  RPCProject
//
//  Created by Beatriz Leonel da Silva on 07/04/24.
//

import SwiftUI

struct InputAddressView: View {
    @Binding var ipAddress: String
    @Binding var userName: String
    var action: (() -> Void)
    @State var isUnavailable: Bool = false
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack {
                    Text("Endereço do servidor")
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                    
                    TextField("ip", text: $ipAddress)
                        .multilineTextAlignment(.center)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                    
                    Text("Nome  de usuário")
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                        .padding(.top)
                    
                    TextField("nome de usuário", text: $userName)
                        .multilineTextAlignment(.center)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                    
                    Button {
                        if (userName.isEmpty) {
                            isUnavailable.toggle()
                        }
                        if !isUnavailable {
                            action()
                        }
                    } label: {
                        Text("Conectar")
                            .foregroundStyle(.blue)
                            .fontWeight(.semibold)
                    }
                    .frame(width: 200, height: 50)
                    .background(.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .padding(.top, 10)
                    
                }
                .frame(height: geo.size.height/2)
                .onTapGesture {
                    UIApplication.shared.endEditing()
                }
            }
            .alert(
                "Adicione um nome de usuátio!",
                isPresented: $isUnavailable) {
                    Button("Ok!") {
                        isUnavailable.toggle()
                    }
                }
        }
    }
}

#Preview {
    InputAddressView(
        ipAddress: .constant("127.0.0.1"),
        userName: .constant("Bia")) {
        print("send new address")
    }
}
