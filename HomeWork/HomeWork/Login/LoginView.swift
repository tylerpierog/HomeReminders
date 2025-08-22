import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel()
    
    var body: some View {
        ZStack {
            Color.backgroundColour
                .ignoresSafeArea()
            if viewModel.isLoading {
                ZStack {
                    loginView
                    ProgressView()
                        .scaleEffect(1.2)
                        .frame(width: 80, height: 80)
                        .background(Color.backgroundColour)
                        .cornerRadius(15)
                }
            } else {
                loginView
            }
        }
    }
    
    private var loginView: some View {
        VStack {
            loginHeaderView
            authenticationView
            Spacer()
        }
        .background(Color.backgroundColour)
        .padding()
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
        Image(decorative: viewModel.imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
    
    private var loginTitleView: some View {
        Text(viewModel.titleText)
            .font(.largeTitle)
            .fontWeight(.regular)
            .foregroundStyle(.black)
    }
    
    private var emailTextFieldView: some View {
        VStack(alignment: .leading) {
            LoginTextFieldView(
                textValue: $viewModel.emailInputString,
                placeholder: viewModel.emailPlaceholder)
            emailTextFieldErrorMessageView
        }
    }
    
    @ViewBuilder
    private var emailTextFieldErrorMessageView: some View {
        if let message = viewModel.emailErrorMessage {
            InlineErrorMessageView(message: message)
        }
    }
    
    private var passwordTextFieldView: some View {
        VStack(alignment: .leading) {
            LoginTextFieldView(
                textValue: $viewModel.passwordInputString,
                placeholder: viewModel.passwordPlaceholder)
            passwordTextFieldErrorMessageView
        }
    }
    
    @ViewBuilder
    private var passwordTextFieldErrorMessageView: some View {
        if let message = viewModel.passwordErrorMessage {
            InlineErrorMessageView(message: message)
        }
    }
    
    private var logInButtonView: some View {
        ButtonView(
            buttonText: viewModel.loginButtonText,
            buttonColour: viewModel.state == .login ? Color.buttonColour : Color.secondaryButtonColour) {
            Task {
                await viewModel.loginOrSignUp()
            }
        }
        .opacity(viewModel.isLoginDisabled ? 0.5 : 1)
        .disabled(viewModel.isLoginDisabled)
    }
    
    private var signupButtonView: some View {
        Button {
            Task {
                viewModel.altButtonAction()
            }
        } label: {
            Text(viewModel.altButtonText)
                .font(.body)
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    LoginView()
}
