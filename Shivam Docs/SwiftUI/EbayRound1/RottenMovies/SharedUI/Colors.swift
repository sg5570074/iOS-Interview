//
//  Colors.swift
//  RottenMovies
//
//  Modern, friendly color palette
//

import SwiftUI

extension Color {
	// MARK: - Primary Colors

	/// Soft cream background - warm and inviting
	static let appBackground = Color(red: 0.98, green: 0.96, blue: 0.94)

	/// Warm coral accent - friendly and energetic
	static let appAccent = Color(red: 1.0, green: 0.45, blue: 0.40)

	/// Soft purple secondary - creative and modern
	static let appSecondary = Color(red: 0.65, green: 0.55, blue: 0.85)

	/// Deep charcoal for text - good contrast
	static let appText = Color(red: 0.20, green: 0.20, blue: 0.25)

	/// Medium gray for secondary text
	static let appTextSecondary = Color(red: 0.50, green: 0.50, blue: 0.55)

	// MARK: - Semantic Colors

	/// Card background - slightly lighter than main background
	static let cardBackground = Color.white

	/// Success/High rating color
	static let appSuccess = Color(red: 0.40, green: 0.80, blue: 0.60)

	/// Warning/Alert color
	static let appWarning = Color(red: 1.0, green: 0.70, blue: 0.30)

	/// Shadow color for depth
	static let appShadow = Color.black.opacity(0.08)
}
