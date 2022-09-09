//
//  ViewController.swift
//  LearningTask-4.4
//
//  Created by rafael.rollo on 15/02/2022.
//

import UIKit

class FormViewController: UIViewController {
    typealias MensagemDeValidacao = String
    
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var areaAtuacaoTextField: UITextField!
    @IBOutlet weak var statusProfissionalTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func botaoSubmissaoPressionado(_ sender: UIButton) {
        switch informacaoValida() {
        case (false, let mensagem):
            exibeAlerta(para: mensagem)
        default:
            exibeAlertaDeConfirmacao()
        }
    }
    
    func emailValido(_ email: String) -> Bool {
        let regexPattern = #"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}"#
        
        return NSPredicate(format: "SELF MATCHES %@", regexPattern).evaluate(with: email)
    }
    
    func informacaoValida() -> (Bool, MensagemDeValidacao?) {
        if let nome = nomeTextField.text, nome.isEmpty {
            return (false, "Nome não pode estar em branco.")
        }
        
        guard let email = emailTextField.text,
              !email.isEmpty else{
            return (false,"Email não pode estar em branco.")
        }
        
        guard emailValido(email) else {
            return (false, "O email informado é inválido.")
        }
        
        if let areaDeAtuacao = areaAtuacaoTextField.text, areaDeAtuacao.isEmpty {
            return (false,"Informe sua área de atuação.")
        }
        
        if let statusProfissional = statusProfissionalTextField.text, statusProfissional.isEmpty {
            return (false,"Informe seu status profissional.")
        }
        
        return (true, nil)
    }
    
    func exibeAlerta(para mensagemDeValidacao: MensagemDeValidacao?) {
        let mensagem = mensagemDeValidacao ?? " Verifique os dados informados e tente novamente."
        
        let alert = UIAlertController(title: "Quase lá", message: mensagem, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    
    func exibeAlertaDeConfirmacao() {
        let alert = UIAlertController(title: "Feito!", message: "Verifique seu email e tenha acesso ao documento.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok!", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

