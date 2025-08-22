import Foundation

protocol AuthenticationErrorTranslating {
    func getPasswordErrorMessage(for error: PasswordAuthenticationError) -> String
    func getEmailErrorMessage(for error: EmailAuthenticationError) -> String
}

struct AuthenticationErrorTranslator: AuthenticationErrorTranslating {
    func getPasswordErrorMessage(for error: PasswordAuthenticationError) -> String {
        return switch error {
        case .emptyPassword: "Password cannot be empty."
        case .passwordTooShort: "Password is too short. Please use at least 8 characters."
        case .passwordMissingDigit: "Password must contain at least one number."
        case .passwordMissingSymbol: "Password must include at least one special character."
        case .passwordContainsWhiteSpace: "Password cannot contain spaces."
        }
    }
    
    func getEmailErrorMessage(for error: EmailAuthenticationError) -> String {
        return switch error {
        case .emptyEmail: "Email address cannot be empty."
        case .invalidEmailFormat: "Please enter a valid email address"
        }
    }
}

