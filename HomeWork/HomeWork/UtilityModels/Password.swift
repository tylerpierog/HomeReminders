struct Password {
    let value: String
}

extension Password {
    var containsDigit: Bool {
        value.range(of: "[0-9]", options: .regularExpression) != nil
    }
    
    var containsSymbol: Bool {
        value.range(of: #"[^\w\s]"#, options: .regularExpression) != nil
    }
}
