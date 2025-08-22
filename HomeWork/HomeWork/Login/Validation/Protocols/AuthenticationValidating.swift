protocol AuthenticationValidating {
    func isValid(_ email: Email) throws(EmailAuthenticationError) -> Bool
    func isValid(_ password: Password) throws(PasswordAuthenticationError) -> Bool
}
