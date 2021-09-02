//
//  ContentView.swift
//  Slot Machine
//
//  Created by Massa Antonio on 31/08/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
		ZStack {
			//MARK: - BACKGROUND
			LinearGradient(gradient: Gradient(colors: [Color("ColorPink"), Color("ColorPurple")]), startPoint: .top, endPoint: .bottom)
				.edgesIgnoringSafeArea(.all)
			//MARK: - INTERFACE
			VStack(alignment: .center, spacing: 5) {

				//MARK: - HEADER
				LogoView()
				Spacer()

				//MARK: - SCORE
				HStack {
					HStack {
						Text("Your\nCoins".uppercased())
							.scoreLabelStyle()
							.multilineTextAlignment(.trailing)
						Text("100")
							.scoreNumberStyle()
							.modifier(ScoreNumberModifier())
							.modifier(ShadowModifier())
					}
					.modifier(ScoreContainerModifier())

					Spacer()

					HStack {
						Text("200")
							.scoreNumberStyle()
							.modifier(ScoreNumberModifier())
						Text("High\nScore".uppercased())
							.scoreLabelStyle()
							.multilineTextAlignment(.leading)
					}
					.modifier(ScoreContainerModifier())
				}
				
				//MARK: - SLOT MACHINE
				VStack(alignment: .center, spacing: 0) {
					//MARK: - REEL n1
					ZStack {
						ReelView()
						Image("gfx-bell")
							.resizable()
							.modifier(ImageModifier())
					}

					HStack(alignment: .center, spacing: 0) {
						//MARK: - REEL n2
						ZStack {
							ReelView()
							Image("gfx-seven")
								.resizable()
								.modifier(ImageModifier())
						}

						Spacer()
						
						//MARK: - REEL n3
						ZStack {
							ReelView()
							Image("gfx-cherry")
								.resizable()
								.modifier(ImageModifier())
						}
					}
					.frame(maxWidth: 500)

					//MARK: - SPIN BUTTON
					Button(action: {
						print("Spin the reels")
					}, label: {
						Image("gfx-spin")
							.renderingMode(.original)
							.resizable()
							.modifier(ImageModifier())
					})
				}
				.layoutPriority(2)

				//MARK: - FOOTER
				Spacer()

				HStack {
					//MARK: - BET 20
					HStack(alignment: .center, spacing: 10) {
						Button(action: {
							print("20 Coins")
						}, label: {
							Text("20")
								.fontWeight(.heavy)
								.foregroundColor(.white)
								.modifier(BetNumberModifier())
						})
						.modifier(BetCapsuleModifier())

						Image("gfx-casino-chips")
							.resizable()
							.opacity(0)
							.modifier(CasinoChipsModifier())
					}

					//MARK: - BET 10
					HStack(alignment: .center, spacing: 10) {
						Image("gfx-casino-chips")
							.resizable()
							.opacity(1)
							.modifier(CasinoChipsModifier())

						Button(action: {
							print("10 Coins")
						}, label: {
							Text("10")
								.fontWeight(.heavy)
								.foregroundColor(.yellow)
								.modifier(BetNumberModifier())
						})
						.modifier(BetCapsuleModifier())
					}
				}
			}
			//MARK: - BUTTONS
			.overlay(
				//RESET BUTTON
				Button(action: {
					print("Reset the game")
				}, label: {
					Image(systemName: "arrow.2.circlepath.circle")
				})
				.modifier(ButtonModifier()),
				alignment: .topLeading
			)
			.overlay(
				//INFO BUTTON
				Button(action: {
					print("Info View")
				}, label: {
					Image(systemName: "info.circle")
				})
				.modifier(ButtonModifier()),
				alignment: .topTrailing
			)
			.padding()
			.frame(maxWidth: 720)
			//MARK: - POPUP

		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}