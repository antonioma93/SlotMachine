//
//  ContentView.swift
//  Slot Machine
//
//  Created by Massa Antonio on 31/08/21.
//

import SwiftUI

struct ContentView: View {
	let symbol = ["gfx-bell", "gfx-cherry", "gfx-coin", "gfx-grape", "gfx-seven", "gfx-strawberry"]

	@State private var highScore: Int = 0
	@State private var coins: Int = 100
	@State private var betAmount: Int = 10
	@State private var reels: Array = [0,1,2]
	@State private var showingInfoView: Bool = false
	@State private var isActiveBet10: Bool = true
	@State private var isActiveBet20: Bool = false
	@State private var showingModal: Bool = false

	//MARK: - FUNCTIONS

	//SPIN THE REELS
	func spinReels() {
		reels = reels.map({ _ in
			Int.random(in: 0...symbol.count - 1)
		})
	}

	//CHECK WINNING
	func checkWinning() {
		if reels[0] == reels[1] && reels[1] == reels[2] && reels[0] == reels[2] {
			//PLAYER WINS
			playerWins()

			//NEW HIGH SCORE
			newHighScore()
		} else {
			//PLAYER LOSES
			playerLoses()
		}
	}

	func playerWins() {
		coins += betAmount * 10
	}

	func newHighScore() {
		highScore = coins
	}

	func playerLoses() {
		coins -= betAmount
	}

	func activateBet20() {
		betAmount = 20
		isActiveBet20 = true
		isActiveBet10 = false
	}

	func activateBet10() {
		betAmount = 10
		isActiveBet10 = true
		isActiveBet20 = false
	}

	//GAME OVER
	func isGameOver() {
		if coins <= 0 {
			//SHOW POPUP
			showingModal = true
		}
	}

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
						Text("\(coins)")
							.scoreNumberStyle()
							.modifier(ScoreNumberModifier())
							.modifier(ShadowModifier())
					}
					.modifier(ScoreContainerModifier())

					Spacer()

					HStack {
						Text("\(highScore)")
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
						Image(symbol[reels[0]])
							.resizable()
							.modifier(ImageModifier())
					}

					HStack(alignment: .center, spacing: 0) {
						//MARK: - REEL n2
						ZStack {
							ReelView()
							Image(symbol[reels[1]])
								.resizable()
								.modifier(ImageModifier())
						}

						Spacer()
						
						//MARK: - REEL n3
						ZStack {
							ReelView()
							Image(symbol[reels[2]])
								.resizable()
								.modifier(ImageModifier())
						}
					}
					.frame(maxWidth: 500)

					//MARK: - SPIN BUTTON
					Button(action: {
						//SPIN REELS
						self.spinReels()

						//CHECK WINNING
						self.checkWinning()

						//GAME OVER
						self.isGameOver()
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
							self.activateBet20()
						}, label: {
							Text("20")
								.fontWeight(.heavy)
								.foregroundColor(isActiveBet20 ? Color("ColorYellow") : Color(.white))
								.modifier(BetNumberModifier())
						})
						.modifier(BetCapsuleModifier())

						Image("gfx-casino-chips")
							.resizable()
							.opacity(isActiveBet20 ? 1 : 0)
							.modifier(CasinoChipsModifier())
					}

					//MARK: - BET 10
					HStack(alignment: .center, spacing: 10) {
						Image("gfx-casino-chips")
							.resizable()
							.opacity(isActiveBet10 ? 1 : 0)
							.modifier(CasinoChipsModifier())
						Button(action: {
							self.activateBet10()
						}, label: {
							Text("10")
								.fontWeight(.heavy)
								.foregroundColor((isActiveBet10 ? Color("ColorYellow") : Color(.white)))
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
					self.showingInfoView = true
				}, label: {
					Image(systemName: "info.circle")
				})
				.modifier(ButtonModifier()),
				alignment: .topTrailing
			)
			.padding()
			.frame(maxWidth: 720)
			.blur(radius: $showingModal.wrappedValue ? 5 : 0, opaque: false)

			//MARK: - POPUP
			if $showingModal.wrappedValue {
				ZStack {
					Color("ColorTransparentBlack").edgesIgnoringSafeArea(.all)

					//MODAL
					VStack(spacing: 0) {
						//TITLE
						Text("Game Over")
							.font(.system(.title, design: .rounded))
							.fontWeight(.heavy)
							.padding()
							.frame(minWidth: 0, maxWidth: .infinity)
							.background(Color("ColorPink"))
							.foregroundColor(.white)

						Spacer()

						//MESSAGE
						VStack(alignment: .center, spacing: 16) {
							Image("gfx-seven-reel")
								.resizable()
								.scaledToFit()
								.frame(maxHeight: 72)
							Text("Oh noo! You lost all your coins. \nKet's play again!")
								.font(.system(.body, design: .rounded))
								.lineLimit(2)
								.multilineTextAlignment(.center)
								.foregroundColor(.gray)
								.layoutPriority(1)

							Button(action: {
								self.showingModal = false
								self.coins = 100
							}, label: {
								Text("New Game".uppercased())
									.font(.system(.body, design: .rounded))
									.fontWeight(.semibold)
									.accentColor(.pink)
									.padding(.horizontal, 12)
									.padding(.vertical, 8)
									.frame(minWidth: 128)
									.background(
										Capsule()
											.strokeBorder(lineWidth: 1.75)
											.foregroundColor(Color("ColorPink"))
									)
							})
						}

						Spacer()
					}
					.frame(minWidth: 280, idealWidth: 280, maxWidth: 320, minHeight: 260, idealHeight: 280, maxHeight: 320, alignment: .center)
					.background(Color(.white))
					.cornerRadius(20)
					.shadow(color: Color("ColorTransparentBlack"), radius: 6, x: 0, y: 8)
				}
			}
		}
		.sheet(isPresented: $showingInfoView, content: {
			InfoView()
		})
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
