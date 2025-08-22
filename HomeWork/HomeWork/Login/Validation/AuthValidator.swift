import Foundation

struct AuthValidator: AuthenticationValidating {
    private let minPasswordLength = 8
    
    func isValid(_ email: Email) throws(EmailAuthenticationError) -> Bool {
        let trimmed = email.value.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { throw .emptyEmail }
        
        let parts = trimmed.split(separator: "@", maxSplits: 1, omittingEmptySubsequences: false)
       
        guard parts.count == 2 else { throw .invalidEmailFormat }
        
        let localPart = parts[0]
        let domainPart = parts[1]
        
        guard !localPart.isEmpty, !domainPart.isEmpty else { throw .invalidEmailFormat }
        
        if localPart.hasPrefix(".") || localPart.hasSuffix(".") || localPart.contains("..") {
            throw .invalidEmailFormat
        }
        
        guard let emailRegex else { throw .invalidEmailFormat }
        
        let range = NSRange(location: 0, length: trimmed.utf16.count)
        
        guard emailRegex.firstMatch(in: trimmed, options: [], range: range) != nil else {
            throw .invalidEmailFormat
        }
        
        return true
    }

    func isValid(_ password: Password) throws(PasswordAuthenticationError) -> Bool {
        if password.value.isEmpty {
            throw PasswordAuthenticationError.emptyPassword
        }
        
        if password.value.count < minPasswordLength {
            throw PasswordAuthenticationError.passwordTooShort
        }
        
        guard password.containsDigit else {
            throw PasswordAuthenticationError.passwordMissingDigit
        }
        
        guard password.containsSymbol else {
            throw PasswordAuthenticationError.passwordMissingSymbol
        }
        
        return true
    }
    
    private var emailRegex: NSRegularExpression? {
        return try? NSRegularExpression(
            pattern: #"^[A-Z0-9._%+\-]+@[A-Z0-9.\-]+\.[A-Z]{2,}$"#,
            options: [.caseInsensitive])
    }
}
