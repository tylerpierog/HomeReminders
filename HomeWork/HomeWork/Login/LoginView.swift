import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        ZStack {
            Color.backgroundColour
                .ignoresSafeArea()
            VStack {
                loginHeaderView
                authenticationView
                Spacer()
            }
            .background(Color.backgroundColour)
            .padding()
        }
    }
    
    private var loginHeaderView: some View {
        VStack(spacing: 0) {
            logoView
            loginTitleView
        }
    }
    
    private var authenticationView: some View {
        VStack(spacing: 20) {
            loginTextFieldsView
            logInButtonView
            signupButtonView
        }
    }
    
    private var loginTextFieldsView: some View {
        VStack {
            emailTextFieldView
            passwordTextFieldView
        }
    }
    
    private var logoView: some View {
        Image(decorative: "house_logo")
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
    
    private var loginTitleView: some View {
        Text("Login")
            .font(.largeTitle)
            .fontWeight(.regular)
            .foregroundStyle(.black)
    }
    
    private var emailTextFieldView: some View {
        LoginTextFieldView(textValue: $email, placeholder: "Email")
    }
    
    private var passwordTextFieldView: some View {
        LoginTextFieldView(textValue: $password, placeholder: "Password")
    }
    
    private var logInButtonView: some View {
        ButtonView(buttonText: "Log In") {
            print("logging in tapped")
        }
        .opacity(isLoginDisabled ? 0.5 : 1)
        .disabled(isLoginDisabled)
    }
    
    private var signupButtonView: some View {
        Button {
            print("sign up tapped")
        } label: {
            Text("Don't have an account? Sign Up")
                .font(.body)
                .foregroundStyle(.gray)
        }
    }
    
    private var isLoginDisabled: Bool {
        email.isEmpty || password.isEmpty
    }
    
    private func loginTapped() {
        print("login tapped")
        //start loading
        //disable the button
        //validate the input
        //auth the user
        //nav to the dashboard
    }
}

#Preview {
    LoginView()
}
