//
//  InfoView.swift
//  Slot Machine
//
//  Created by Massa Antonio on 02/09/21.
//

import SwiftUI

struct InfoView: View {
	@Environment(\.presentationMode) var presentationMode

    var body: some View {
		VStack(alignment: .center, spacing: 10) {
			LogoView()
			Spacer()
			Form {
				Section(header: Text("About the application")) {
					FormRowView(firstItem: "Application", secondItem: "Slot Machine")
					FormRowView(firstItem: "Platforms", secondItem: "iPhone, iPad, Mac")
					FormRowView(firstItem: "Developer", secondItem: "Antonio Massa")
					FormRowView(firstItem: "Designer", secondItem: "Antonio Massa")
					FormRowView(firstItem: "Music", secondItem: "Dan Lebowitz")
					FormRowView(firstItem: "Website", secondItem: "swiftuimasterclass.com")
					FormRowView(firstItem: "Copyright", secondItem: "© 2021 All right reserved.")
					FormRowView(firstItem: "Version", secondItem: "1.0.0")




				}
			}
			.font(.system(.body, design: .rounded))
		}
		.padding(.top, 40)
		.overlay(
			Button(action: {
				//Action
				audioPlayer?.stop()
				self.presentationMode.wrappedValue.dismiss()
			}, label: {
				Image(systemName: "xmark.circle")
					.font(.title)
			})
			.padding(.top, 30)
			.padding(.trailing, 20)
			.accentColor(.secondary)
			,alignment: .topTrailing
		)
		.onAppear(perform: {
			playSound(sound: "background-music", type: "mp3")
		})
    }
}

struct FormRowView: View {
	var firstItem: String
	var secondItem: String

	var body: some View {
		HStack {
			Text(firstItem).foregroundColor(.gray)
			Spacer()
			Text(secondItem)
		}
	}
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}

