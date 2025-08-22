import SwiftUI

enum AuthenticationStep {
    case login
    case signUp
}

@MainActor
class LoginViewModel: ObservableObject {
    @Published var emailInputString: String
    @Published var passwordInputString: String
    @Published var emailErrorMessage: String?
    @Published var passwordErrorMessage: String?
    @Published var isLoading: Bool
    @Published var state: AuthenticationStep = .login
    
    weak var session: AppSession?
    
    private(set) var validator: AuthenticationValidating
    private(set) var errorMessageTranslator: AuthenticationErrorTranslating
    
    init(
        email: String = "",
        password: String = "",
        isLoading: Bool = false,
        validator: AuthenticationValidating = AuthValidator(),
        errorMessageManager: AuthenticationErrorTranslating = AuthenticationErrorTranslator()) {
        self.emailInputString = email
        self.passwordInputString = password
        self.isLoading = isLoading
        self.validator = validator
        self.errorMessageTranslator = errorMessageManager
    }
    
    // MARK: View Content
    
    let emailPlaceholder = "Email"
    let passwordPlaceholder = "Password"
    let imageName = "house_logo"
    
    var loginButtonText: String {
        state == .login
        ? "Log In"
        : "Sign Up"
    }
    
    var authenticationWelcomeText: String {
        state == .login
        ? "Welcome back - sign in to continue"
        : "Create your account to continue"
    }
    
    var titleText: String {
        state == .login
        ? "Login"
        : "Sign Up"
    }
    
    var altButtonText: String {
        state == .login
        ? "Don't have an account? Sign Up"
        : "Already have an account?"
    }
    
    var isLoginDisabled: Bool {
        emailInputString.isEmpty || passwordInputString.isEmpty || isLoading
    }
    
    // MARK: Email and Password Objects
    
    private var email: Email {
        Email(value: emailInputString)
    }
    
    private var password: Password {
        Password(value: passwordInputString)
    }
    
    // MARK: Login and Sign up actions
    
    func loginOrSignUp() async {
        isLoading = true

        switch state {
        case .login:
            await authenticateUser()
        case .signUp:
            await signUp()
        }
        
        isLoading = false
    }
    
    func altButtonAction() {
        clearTextFields()
        clearErrorMessages()
        
        switch state {
        case .login:
            state = .signUp
        case .signUp:
            state = .login
        }
    }
    
    private func clearTextFields() {
        emailInputString = ""
        passwordInputString = ""
    }
    
    private func clearErrorMessages() {
        emailErrorMessage = nil
        passwordErrorMessage = nil
    }
    
    private func authenticateUser() async {
        let isEmailEmpty = email.value.replacingOccurrences(of: " ", with: "").isEmpty
        let isPasswordEmpty = password.value.replacingOccurrences(of: " ", with: "").isEmpty
       
        if isEmailEmpty {
            emailErrorMessage = errorMessageTranslator.getEmailErrorMessage(for: .emptyEmail)
        }
        
        if isPasswordEmpty {
            passwordErrorMessage = errorMessageTranslator.getPasswordErrorMessage(for: .emptyPassword)
        }
        
        if !isEmailEmpty && !isPasswordEmpty {
            try? await Task.sleep(for: .seconds(2))
            session?.didAuthenticate()
        }
    }
    
    private func signUpUser() async {
        try? await Task.sleep(for: .seconds(2))
        session?.didAuthenticate()
    }
    
    private func signUp() async {
        var isEmailValid = false
        var isPasswordValid = false
        
        do throws(EmailAuthenticationError) {
            isEmailValid = try validator.isValid(email)
            emailErrorMessage = nil
        } catch {
            handleEmail(error)
        }
        
        do throws(PasswordAuthenticationError) {
            isPasswordValid = try validator.isValid(password)
            passwordErrorMessage = nil
        } catch {
            handlePassword(error)
        }
        
        guard isEmailValid, isPasswordValid else { return }
                
        print("all valid!")
        
        await signUpUser()
        
        print("signed up")
    }
    
    private func handleEmail(_ error: EmailAuthenticationError) {
        emailErrorMessage = errorMessageTranslator.getEmailErrorMessage(for: error)
    }
    
    private func handlePassword(_ error: PasswordAuthenticationError) {
        passwordErrorMessage = errorMessageTranslator.getPasswordErrorMessage(for: error)
    }
}
