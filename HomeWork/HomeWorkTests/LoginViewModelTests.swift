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
    
    @Test func altButtonActionClearsTextFielsAndErrors() async throws {
        let vm = LoginViewModel(email: "wwer@gmail.com", password: "password#1")
        
        vm.emailErrorMessage = "Email error"
        vm.passwordErrorMessage = "Password error"
        
        #expect(vm.emailErrorMessage == "Email error")
        #expect(vm.passwordErrorMessage == "Password error")
        
        vm.altButtonAction()
        
        #expect(vm.emailErrorMessage == nil)
        #expect(vm.passwordErrorMessage == nil)
        #expect(vm.emailInputString == "")
        #expect(vm.passwordInputString == "")
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
}
