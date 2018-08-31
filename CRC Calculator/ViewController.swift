//
//  ViewController.swift
//  CRC Calculator
//
//  Created by Romuald Dufaux on 31/08/18.
//  Copyright © 2018 dPro. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTokenFieldDelegate {
	@IBOutlet var tokenField: NSTokenField!
	@objc dynamic var crc = "none"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tokenField.tokenizingCharacterSet = CharacterSet.punctuationCharacters.union(.whitespacesAndNewlines)
	}
	
	func tokenField(_ tokenField: NSTokenField, shouldAdd tokens: [Any], at index: Int) -> [Any] {
		return tokens.compactMap { UInt8(($0 as! String).replacingOccurrences(of: "0x", with: ""), radix: 16) }
	}
	
	func tokenField(_ tokenField: NSTokenField, displayStringForRepresentedObject representedObject: Any) -> String? {
		let hex = String(representedObject as? UInt8 ?? 0, radix: 16)
		if hex.count == 1 {
			return "0" + hex
		} else {
			return hex
		}
	}
	
	@IBAction func didChangeHexValue(_ sender: NSTokenField) {
		crc = "0x" + String(crc(of: sender.objectValue as! [UInt8]), radix: 16)
	}

	func crc(of bytes: [UInt8]) -> UInt8 {
		var mutableBytes = bytes
		var result: UInt8 = 0
		mif_calc_crc(UInt8(CRC8), Int32(bytes.count), &mutableBytes, &result)
		return result
	}
}
