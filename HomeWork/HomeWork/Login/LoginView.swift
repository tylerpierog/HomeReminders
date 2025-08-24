import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var session: AppSession
    @ObservedObject var viewModel = LoginViewModel()
    @Environment(\.horizontalSizeClass) private var sizeClass
    
    var body: some View {
        ZStack {
            Color.backgroundColour
                .ignoresSafeArea()
            if viewModel.isLoading {
                ZStack {
                    loginView
                        .blur(radius: 2)
                    Color.black.opacity(0.25)
                        .ignoresSafeArea()
                        .transition(.opacity)
                    
                    ProgressView()
                        .scaleEffect(1.2)
                        .frame(width: 80, height: 80)
                        .background(Color.secondaryButtonColour.opacity(0.7))
                        .cornerRadius(15)
                }
            } else {
                loginView
            }
        }
        .onAppear {
            if viewModel.session !== session {
                viewModel.session = session
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
            HomeWorkBrandingHeaderView()
                .padding(.bottom, 6)
            logoView
            loginTitleView
                .accessibilityAddTraits(.isHeader)
        }
    }
    
    private var authenticationView: some View {
        VStack(spacing: 40) {
            loginTextFieldsView
            logInButtonView
            signupButtonView
        }
        .frame(maxWidth: 560)
    }
    
    private var loginTextFieldsView: some View {
        VStack(spacing: 20) {
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
        VStack(spacing: 10) {
            Text(viewModel.titleText)
                .font(.system(size: sizeClass == .regular ? 38 : 28, weight: .bold, design: .rounded))
                .foregroundStyle(.black)
                .padding(.horizontal, 18)
                .padding(.vertical, 8)
                .animation(.easeInOut(duration: 0.5), value: viewModel.titleText)
            
            Text(viewModel.authenticationWelcomeText)
                .font(.system(size: sizeClass == .regular ? 18 : 16, weight: .regular, design: .rounded))
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)
                .animation(.easeInOut(duration: 0.5), value: viewModel.authenticationWelcomeText)
        }
    }
    
    private var emailTextFieldView: some View {
        VStack(alignment: .leading) {
            LoginTextFieldView(
                textValue: $viewModel.emailInputString,
                placeholder: viewModel.emailPlaceholder)
            emailTextFieldErrorMessageView
        }
        .accessibilityElement(children: .combine)
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
                placeholder: viewModel.passwordPlaceholder,
                isSecure: true)
            passwordTextFieldErrorMessageView
        }
        .accessibilityElement(children: .combine)
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
        .animation(.spring(response: 0.55, dampingFraction: 0.85), value: viewModel.state)
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
