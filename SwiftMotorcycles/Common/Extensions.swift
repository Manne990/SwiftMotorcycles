//
//  Extensions.swift
//  SwiftMotorcycles
//
//  Created by Jonas Frid on 2021-02-18.
//  Copyright © 2021 Jonas Frid. All rights reserved.
//

import Foundation

//// EditText
//fun EditText.textAsString(): String {
//    return this.text.toString()
//}
//
//fun EditText.textAsInt(): Int {
//    return this.textAsString().toIntOrNull() ?: 0
//}
//
//fun EditText.setInt(value: Int, zeroIsBlank: Boolean = true) {
//    if (zeroIsBlank && value == 0) {
//        this.setText("")
//        return
//    }
//    this.setText(value.toString())
//}
//
//fun EditText.validate(validator: (String) -> Boolean, message: String): Boolean {
//    this.doAfterTextChanged {
//        this.error = if (validator(it.toString())) null else message
//    }
//    this.error = if (validator(this.text.toString())) null else message
//
//    return this.error == null
//}
//
//// String
//fun String.toIntOrZero(): Int {
//    return this.toIntOrNull() ?: 0
//}
