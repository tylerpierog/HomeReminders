enum PasswordAuthenticationError: Error {
    case emptyPassword
    case passwordTooShort
    case passwordMissingDigit
    case passwordMissingSymbol
    case passwordContainsWhiteSpace
}
