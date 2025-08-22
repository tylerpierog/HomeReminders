import Testing
@testable import HomeWork

struct AuthenticationErrorTranslatorTests {
    @Test func passwordEmptyPasswordMessage() async throws {
        let translator = AuthenticationErrorTranslator()
        
        #expect(translator.getPasswordErrorMessage(for: .emptyPassword) == "Password cannot be empty.")
    }
    
    @Test func passwordTooShortMessage() async throws {
        let translator = AuthenticationErrorTranslator()
        
        #expect(translator.getPasswordErrorMessage(for: .passwordTooShort) == "Password is too short. Please use at least 8 characters.")
    }
    
    @Test func passwordMissingDigitMessage() async throws {
        let translator = AuthenticationErrorTranslator()
        
        #expect(translator.getPasswordErrorMessage(for: .passwordMissingDigit) == "Password must contain at least one number.")
    }
    
    @Test func passwordMissingSymbolMessage() async throws {
        let translator = AuthenticationErrorTranslator()
        
        #expect(translator.getPasswordErrorMessage(for: .passwordMissingSymbol) == "Password must include at least one special character.")
    }
    
    @Test func passwordContainsWhitespaceMessage() async throws {
        let translator = AuthenticationErrorTranslator()
        
        #expect(translator.getPasswordErrorMessage(for: .passwordContainsWhiteSpace) == "Password cannot contain spaces.")
    }
        
    @Test func emailEmptyEmailMessage() async throws {
        let translator = AuthenticationErrorTranslator()
        
        #expect(translator.getEmailErrorMessage(for: .emptyEmail) == "Email address cannot be empty.")
    }
    
    @Test func emailInvalidFormatMessage() async throws {
        let translator = AuthenticationErrorTranslator()
        
        #expect(translator.getEmailErrorMessage(for: .invalidEmailFormat) == "Please enter a valid email address")
    }
}
