//
//  Extension.swift
//  Slot Machine
//
//  Created by Massa Antonio on 02/09/21.
//

import SwiftUI

extension Text {
	func scoreLabelStyle() -> Text {
		self
			.foregroundColor(.white)
			.font(.system(size: 10, weight: .bold, design: .rounded))
	}
	func scoreNumberStyle() -> Text {
		self
			.foregroundColor(.white)
			.font(.system(.title, design: .rounded))
			.fontWeight(.heavy)
	}
}
