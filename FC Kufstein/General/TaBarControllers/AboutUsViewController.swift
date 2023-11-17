//
//  AboutUsViewController.swift
//  FC Kufstein
//
//  Created by Adnann Muratovic on 16.11.23.
//

import UIKit
import MessageUI

class AboutUsViewController: UIViewController {
    
    // MARK: - Properties
    private var viewModel = AboutUsViewModel()
    
    // MARK: - Components
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(AboutUsTableViewCell.self, forCellReuseIdentifier: AboutUsTableViewCell.cellID)
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.configure()
        tableView.reloadData()
    }
}

// MARK: - SetupUI
private extension AboutUsViewController {
    private func setupUI() {
        title = "About Us"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemGray6
        setupTableView()
        viewModel.delegate = self
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension AboutUsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.models[indexPath.section].options[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AboutUsTableViewCell.cellID, for: indexPath) as? AboutUsTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = viewModel.models[indexPath.section].options[indexPath.row]
        model.handler()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let model = viewModel.models[section]
        return model.tittle
    }
}

extension AboutUsViewController: AboutUsViewModelDelegate {
    
    func sendEmail() {
        sendingEmail()
    }
    
    func phoneCall() {        
        makePhoneCall()
    }
    
    func openURL(withURL url: String) {
        presentSafariController(withURL: URL(string: url)!)
    }
    
    /// Helpers
    fileprivate func sendingEmail() {
        guard MFMailComposeViewController.canSendMail() else {
            showMessage(title: "Fehler", message: "Ihr Gerät kann keine E-Mails senden. Bitte überprüfen Sie Ihre E-Mail-Einstellungen.")
            return
        }
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setSubject("FC Kufstein Unterstützung")
        composer.setToRecipients(["info@fc-kufstein.at"])
        composer.setMessageBody("Hallo,\n\nVielen Dank, dass Sie uns kontaktieren. Bitte hinterlassen Sie hier Ihre Nachricht oder Anfrage.\n\nMit freundlichen Grüßen,\nIhr Team von FC Kufstein", isHTML: false)
        present(composer, animated: true)
    }
    
    // Helpers
    fileprivate func makePhoneCall() {
        guard let numberURL = URL(string: "tel://+43537264801") else {
            return
        }
        
        UIApplication.shared.open(numberURL, options: [:], completionHandler: nil)
    }
}


extension AboutUsViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            controller.dismiss(animated: true) {
                self.showMessage(title: "E-Mail Abgebrochen", message: "Sie haben die E-Mail-Komposition abgebrochen.")
            }
        case .sent:
            controller.dismiss(animated: true) {
                self.showMessage(title: "E-Mail Gesendet", message: "Ihre E-Mail wurde erfolgreich gesendet.")
            }
        case .failed:
            controller.dismiss(animated: true) {
                self.showMessage(title: "E-Mail Sendefehler", message: "Senden der E-Mail fehlgeschlagen. Bitte versuchen Sie es erneut.")
            }
        case .saved:
            controller.dismiss(animated: true) {
                self.showMessage(title: "E-Mail Gespeichert", message: "Ihre E-Mail wurde als Entwurf gespeichert.")
            }
        @unknown default:
            break
        }
    }
    
    private func showMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
    }
}




