import Testing
@testable import HomeWork

struct AuthValidatorTests {
    // MARK: Email Validation
    
    @Test func emptyEmailThrowsEmptyEmailError() async throws {
        let validator = AuthValidator()

        let email = Email(value: "")
        
        #expect(throws: EmailAuthenticationError.emptyEmail) {
            try validator.isValid(email)
        }
    }
    
    @Test func validEmails() throws {
        let validator = AuthValidator()
        
        let genericEmail = Email(value: "john.doe@example.com")
        let simpleEmail = Email(value: "a@b.co")
        let caseInsensitiveEmail = Email(value: "user@EXAMPLE.CoM")
        
        #expect(try validator.isValid(genericEmail))
        #expect(try validator.isValid(simpleEmail))
        #expect(try validator.isValid(caseInsensitiveEmail))
    }
    
    @Test func isValidEmailTrimsWhitespace() throws {
        let validator = AuthValidator()
        
        let whitespaceEmail = Email(value: "  user@example.com  ")
        
        #expect(try validator.isValid(whitespaceEmail))
    }
    
    @Test func missingDomainEmail() throws {
        let validator = AuthValidator()
        
        let emailMissingDomain = Email(value: "user@")
        
        #expect(throws: EmailAuthenticationError.invalidEmailFormat) {
            try validator.isValid(emailMissingDomain)
        }
    }
    
    @Test func missingLocalPortEmail() throws {
        let validator = AuthValidator()
        
        let emailMissingLocalPort = Email(value: "@example.com")
        
        #expect(throws: EmailAuthenticationError.invalidEmailFormat) {
            try validator.isValid(emailMissingLocalPort)
        }
    }
    
    @Test func missingDotInDomainEmail() throws {
        let validator = AuthValidator()
        
        let emailMissingDotInDomain = Email(value: "user@example")
        
        #expect(throws: EmailAuthenticationError.invalidEmailFormat) {
            try validator.isValid(emailMissingDotInDomain)
        }
    }
    
    @Test func consecutiveDotsInLocalPartEmail() throws {
        let validator = AuthValidator()
        let consecutiveDotsEmail = Email(value: "first..last@example.com")

        #expect(throws: EmailAuthenticationError.invalidEmailFormat) {
            try validator.isValid(consecutiveDotsEmail)
        }
    }

    @Test func leadingDotInLocalPartEmail() throws {
        let validator = AuthValidator()
        let leadingDotEmail = Email(value: ".first@example.com")

        #expect(throws: EmailAuthenticationError.invalidEmailFormat) {
            try validator.isValid(leadingDotEmail)
        }
    }

    @Test func trailingDotInLocalPartEmail() throws {
        let validator = AuthValidator()
        let trailingDotEmail = Email(value: "first.@example.com")

        #expect(throws: EmailAuthenticationError.invalidEmailFormat) {
            try validator.isValid(trailingDotEmail)
        }
    }

    @Test func spacesInsideEmail() throws {
        let validator = AuthValidator()
        let spacesInsideEmail = Email(value: "user name@example.com")

        #expect(throws: EmailAuthenticationError.invalidEmailFormat) {
            try validator.isValid(spacesInsideEmail)
        }
    }

    @Test func unicodeEmail() throws {
        let validator = AuthValidator()
        let unicodeLocalPartEmail = Email(value: "jöhn@example.com")

        #expect(throws: EmailAuthenticationError.invalidEmailFormat) {
            try validator.isValid(unicodeLocalPartEmail)
        }
    }

    @Test func invalidSymbolInLocalPartEmail() throws {
        let validator = AuthValidator()
        let invalidSymbolInLocalPartEmail = Email(value: "user/name@example.com")

        #expect(throws: EmailAuthenticationError.invalidEmailFormat) {
            try validator.isValid(invalidSymbolInLocalPartEmail)
        }
    }
    
    // MARK: Password Validation
    
    @Test func emptyPassword_throws() {
        let validator = AuthValidator()
        
        let emptyPassword = Password(value: "")
        
        #expect(throws: PasswordAuthenticationError.emptyPassword) {
            try validator.isValid(emptyPassword)
        }
    }

    @Test func tooShortPassword_throws() {
        let validator = AuthValidator()

        let tooShort = Password(value: "A1!")
        
        #expect(throws: PasswordAuthenticationError.passwordTooShort) {
            try validator.isValid(tooShort)
        }
    }

    @Test func missingDigit_throws() {
        let validator = AuthValidator()
        
        let noDigit = Password(value: "Abcdefg!")
        
        #expect(throws: PasswordAuthenticationError.passwordMissingDigit) {
            try validator.isValid(noDigit)
        }
    }

    @Test func missingSymbol_throws() {
        let validator = AuthValidator()
        
        let noSymbol = Password(value: "Abcdef12")
        
        #expect(throws: PasswordAuthenticationError.passwordMissingSymbol) {
            try validator.isValid(noSymbol)
        }
    }

    @Test func validPassword_passes() throws {
        let validator = AuthValidator()
        
        let good = Password(value: "Abcd12!@")
        
        #expect(try validator.isValid(good))
    }
}
