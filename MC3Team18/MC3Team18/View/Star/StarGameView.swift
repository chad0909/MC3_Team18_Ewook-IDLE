//
//  StarGameView.swift
//  MC3Team18
//
//  Created by Lee Jinhee on 2023/07/23.
//

import SwiftUI

struct StarGameView: View {
    @State var starStatus: StarStatus = .tutorial
    @Binding var gameSelection: GameSelection
    
    @State var starScore: Int = 0
    @State var secondsx4 = 120
    
    @State var gameOpacity: Double = 0

    var body: some View {
        ZStack {
            Color.clear.overlay {
                Image("BackgroundStar")
                    .resizable()
                    .scaledToFill()
            }
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Text("Score: ")
                        .pretendardRegular20()
                        .frame(height: 29)
                    Text("\(starScore)")
                        .pretendardSemiBold24()
                        .foregroundColor(.Yellow)
                    //TODO: ScaleEffect
                    Spacer()
                    Button {
                        //TODO: starState = 일시정지
                        starStatus = .pause
                    } label: {
                        Image(systemName: "pause.fill")
                            .resizable()
                            .pretendardSemiBold20()
                            .frame(width: 16, height: 16)
                            .padding(.vertical, 3.5)
                            .padding(.horizontal, 4)
                    }
                }
                .foregroundColor(.white)
                .padding(.bottom, 5)
                .frame(height: 29)
                
                HStack(spacing: 4) {
                    Image(systemName: "hourglass")
                        .resizable()
                        .scaledToFit()
                        .pretendardSemiBold20()
                        .frame(width: 15, height: 24)
                        .foregroundColor(.white)
                    Spacer()
                    Capsule()
                        .frame(height: 16)
                        .foregroundColor(.white).opacity(0.4)
                        .overlay {
                            GeometryReader { geo in
                                HStack {
                                    Capsule()
                                        .frame(height: 10)
                                        .frame(width: (geo.size.width - 10) * (CGFloat(secondsx4) / 120))
                                        .offset(y: -1)
                                        .foregroundColor(.white.opacity(0.9))
                                        .padding(4)
                                    Spacer()
                                }
                            }
                        }
                }
                .frame(height: 31)
                .padding(.bottom, 17)
                Spacer()
                
                Image("MainCharacter")
                    .resizable()
                    .frame(width: 180, height: 201)
                    .onTapGesture {
                        starStatus = .gameover
                    }
            }
            .padding(.top, 50)
            .padding(.bottom, 32)
            .padding(.horizontal, 34)
            
            
            switch starStatus {
            case .tutorial:
               // TODO: UserDefaults의 튜토리얼 변수 조건에 따라 visible
                    StarTutorialView(starStatus: $starStatus)
                        .transition(.opacity)
            case .game:
                EmptyView()
            case .pause:
                StarPauseView(starStatus: $starStatus, gameSelection: $gameSelection)
            case .gameover:
                StarGameOverView(starScore: $starScore, starStatus: $starStatus, gameSelection: $gameSelection)
            }
        }
        .statusBarHidden()
        .ignoresSafeArea()
        .opacity(gameOpacity)
        .onAppear {
            withAnimation(.easeOut(duration: 0.3)) {
                gameOpacity = 1
            }
        }
    }
}

struct StarGameView_Previews: PreviewProvider {
    static var previews: some View {
        StarGameView(gameSelection: .constant(.star))
    }
}