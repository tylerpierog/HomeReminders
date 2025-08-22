import Testing
@testable import HomeWork

@MainActor
struct LoginViewModelTests {
    
    @Test func emailPlaceholder() async throws {
        let vm = LoginViewModel()
        
        #expect(vm.emailPlaceholder == "Email")
    }

    @Test func passwordPlaceholder() async throws {
        let vm = LoginViewModel()
        
        #expect(vm.passwordPlaceholder == "Password")
    }

    @Test func imageName() async throws {
        let vm = LoginViewModel()
        
        #expect(vm.imageName == "house_logo")
    }
    
    @Test func authenticationWelcomeTextForLoginState() async throws {
        let vm = LoginViewModel()
        
        vm.state = .login
        
        #expect(vm.authenticationWelcomeText == "Welcome back - sign in to continue")
    }
    
    @Test func authenticationWelcomeTextForSignUpState() async throws {
        let vm = LoginViewModel()
        
        vm.state = .signUp
        
        #expect(vm.authenticationWelcomeText == "Create your account to continue")
    }

    @Test func titleTextForLoginState() async throws {
        let vm = LoginViewModel()
        
        vm.state = .login
        
        #expect(vm.titleText == "Login")
    }

    @Test func loginButtonTextForLoginState() async throws {
        let vm = LoginViewModel()
        
        vm.state = .login
        
        #expect(vm.loginButtonText == "Log In")
    }

    @Test func altButtonTextForLoginState() async throws {
        let vm = LoginViewModel()
        
        vm.state = .login
        
        #expect(vm.altButtonText == "Don't have an account? Sign Up")
    }

    @Test func titleTextForSignUpState() async throws {
        let vm = LoginViewModel()
        
        vm.state = .signUp
        
        #expect(vm.titleText == "Sign Up")
    }

    @Test func loginButtonTextForSignUpState() async throws {
        let vm = LoginViewModel()
        
        vm.state = .signUp
        
        #expect(vm.loginButtonText == "Sign Up")
    }

    @Test func altButtonTextForSignUpState() async throws {
        let vm = LoginViewModel()
        
        vm.state = .signUp
        
        #expect(vm.altButtonText == "Already have an account?")
    }
    
    @Test func loginOrSignUpEmitsLoadingStatesInLoginState() async throws {
        let vm = LoginViewModel()
        vm.state = .login
        
        var values: [Bool] = []
        let cancellable = vm.$isLoading
            .sink { values.append($0) }
        
        await vm.loginOrSignUp()
        
        cancellable.cancel()
                
        #expect(values.first == false)
        #expect(values[1] == true)
        #expect(values.last == false)
    }
    
    @Test func altButtonActionClearsTextFielsAndErrorsForLoginState() async throws {
        let vm = LoginViewModel(email: "wwer@gmail.com", password: "password#1")
        vm.state = .login
        
        vm.emailErrorMessage = "Email error"
        vm.passwordErrorMessage = "Password error"
        
        #expect(vm.emailErrorMessage == "Email error")
        #expect(vm.passwordErrorMessage == "Password error")
        #expect(vm.state == .login)
        
        vm.altButtonAction()
        
        #expect(vm.emailErrorMessage == nil)
        #expect(vm.passwordErrorMessage == nil)
        #expect(vm.emailInputString == "")
        #expect(vm.passwordInputString == "")
        #expect(vm.state == .signUp)
    }
    
    @Test func altButtonActionClearsTextFielsAndErrorsForSignUpState() async throws {
        let vm = LoginViewModel(email: "wwer@gmail.com", password: "password#1")
        vm.state = .signUp
        
        vm.emailErrorMessage = "Email error"
        vm.passwordErrorMessage = "Password error"
        
        #expect(vm.emailErrorMessage == "Email error")
        #expect(vm.passwordErrorMessage == "Password error")
        #expect(vm.state == .signUp)
        
        vm.altButtonAction()
        
        #expect(vm.emailErrorMessage == nil)
        #expect(vm.passwordErrorMessage == nil)
        #expect(vm.emailInputString == "")
        #expect(vm.passwordInputString == "")
        #expect(vm.state == .login)
    }
    
    @Test func isLoginDisabledWhenEmailIsEmpty() async throws {
        let vm = LoginViewModel(email: "", password: "password#1")
        
        #expect(vm.isLoginDisabled)
    }
    
    @Test func isLoginDisabledWhenPasswordIsEmpty() async throws {
        let vm = LoginViewModel(email: "wwer@gmail.com", password: "")
        
        #expect(vm.isLoginDisabled)
    }
    
    @Test func isLoginDisabledWhileLoading() async throws {
        let vm = LoginViewModel(email: "wwer@gmail.com", password: "validpass@@#5")
        
        vm.isLoading = true
        
        #expect(vm.isLoginDisabled)
    }
    
    @Test func loginOrSignUpWithEmptyTextFieldsForLoginState() async throws {
        let vm = LoginViewModel(email: "", password: "")
        vm.state = .login
        
        await vm.loginOrSignUp()
        
        #expect(vm.emailErrorMessage == "Email address cannot be empty.")
        #expect(vm.passwordErrorMessage == "Password cannot be empty.")
    }
    
    @Test func loginOrSignUpClearsErrorsOnSuccessfulSignUp() async throws {
        let vm = LoginViewModel(email: "", password: "")
        vm.state = .signUp
        
        await vm.loginOrSignUp()
        
        #expect(vm.emailErrorMessage == "Email address cannot be empty.")
        #expect(vm.passwordErrorMessage == "Password cannot be empty.")
        
        vm.emailInputString = "test@test.com"
        vm.passwordInputString = "validpass@@#5"
        
        await vm.loginOrSignUp()
        
        #expect(vm.emailErrorMessage == nil)
        #expect(vm.passwordErrorMessage == nil)
    }
}
