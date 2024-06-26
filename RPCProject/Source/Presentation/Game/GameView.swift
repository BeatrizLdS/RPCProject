//
//  ContentView.swift
//  RPCProject
//
//  Created by Beatriz Leonel da Silva on 02/04/24.
//

import SwiftUI

struct GameView: View {
    @ObservedObject private var viewModel: ViewModel = ViewModel()
    
    @State var text: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                switch viewModel.viewState {
                case .notStarted :
                    InputAddressView(
                        ipAddress: $viewModel.ipAddress,
                        userName: $viewModel.currentUserName
                    ) {
                        Task {
                            await viewModel.start()                            
                        }
                    }
                case .loading:
                    ProgressView()
                case .waitingPlayer:
                    Text("Esperando outro jogador")
                case .inGame:
                    VStack {
                        BoardView(
                            viewModel: viewModel
                        )
                        .background(Color.white)
                        .onAppear {
                            Task {
                                await viewModel.receiveMoves()
                            }
                        }
                        ChatView(
                            text: $viewModel.inputUser,
                            messages: $viewModel.messages) {
                                Task {
                                    await viewModel.sendMessage()                                    
                                }
                            }
                            .onAppear {
                                Task {
                                    await viewModel.receiveMessages()
                                }
                            }
                    }
                    .overlay(alignment: .topTrailing) {
                        Button {
                            Task {
                                await viewModel.playAgain()
                            }
                        } label: {
                            Image(systemName: "arrow.counterclockwise.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                                .background {
                                    Circle()
                                        .fill(.blue)
                                        .frame(width: 30, height: 30)
                                }
                                .padding(.trailing, 10)
                        }
                        .shadow(color:.black.opacity(25), radius: 3)
                    }
                case .endGame:
                    Text(viewModel.isWinner ? "You Win" : "You Lose")
                    Button {
                        Task {
                            await viewModel.playAgain()                            
                        }
                    } label: {
                        Text("Play again")
                    }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color.white)
        }
    }
}

#Preview {
    GameView()
}
