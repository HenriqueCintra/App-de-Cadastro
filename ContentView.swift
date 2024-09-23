//
//  ContentView.swift
//  CadastroApp
//
//  Created by José Henrique Cintra de Souza Barros on 22/09/24.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    @State private var nome: String = ""
    @State private var cpf: String = ""
    @State private var residencia: String = ""
    @State private var nomeDoacao: String = ""
    @State private var numDoacoes: String = ""
    @State private var selectedImage: UIImage? = nil
    @State private var showPhotoPicker: Bool = false
    @State private var showAdminLogin: Bool = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                Text("\nProjeto Erbs")
                    .font(.largeTitle)
                    .padding()

                // Campos de texto para o cadastro
                TextField("Nome", text: $nome)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("CPF", text: $cpf)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Residência", text: $residencia)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Nome da Doação", text: $nomeDoacao)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Número de Ramas Doadas", text: $numDoacoes)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                // Opção de foto
                Button(action: {
                    showPhotoPicker = true
                }) {
                    Text(selectedImage == nil ? "Adicionar Foto (Opcional)" : "Alterar Foto")
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                }
                .padding()
                .sheet(isPresented: $showPhotoPicker) {
                    ImagePicker(image: $selectedImage)
                }

                // Exibição da foto (se selecionada)
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                        .padding()
                }

                // Botão de cadastro
                Button(action: {
                    guard !nome.isEmpty, !cpf.isEmpty, !residencia.isEmpty, !nomeDoacao.isEmpty, !numDoacoes.isEmpty else {
                        // Mostrar alerta se campos estiverem vazios
                        return
                    }
                    
                    var cadastro: [String: String] = ["nome": nome, "cpf": cpf, "residencia": residencia, "nomeDoacao": nomeDoacao, "numDoacoes": numDoacoes]

                    // Salvar imagem como Data, se disponível
                    if let image = selectedImage, let imageData = image.jpegData(compressionQuality: 0.8) {
                        cadastro["foto"] = imageData.base64EncodedString()
                    }

                    // Salvar cadastro em UserDefaults
                    var cadastros = UserDefaults.standard.array(forKey: "cadastros") as? [[String: String]] ?? []
                    cadastros.append(cadastro)
                    UserDefaults.standard.set(cadastros, forKey: "cadastros")
                    
                    // Limpar os campos após cadastro
                    nome = ""
                    cpf = ""
                    residencia = ""
                    nomeDoacao = ""
                    numDoacoes = ""
                    selectedImage = nil
                    
                    print("Cadastro salvo em UserDefaults: \(cadastro)")
                }) {
                    Text("Cadastrar")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()

                Spacer()

                // Botão para entrar na tela de administrador
                Button(action: {
                    showAdminLogin = true
                }) {
                    Text("Administrador")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
                .sheet(isPresented: $showAdminLogin) {
                    AdminLoginView()
                }
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .edgesIgnoringSafeArea(.all)
        }
    }
}

// Tela de login para administrador
struct AdminLoginView: View {
    @State private var senha: String = ""
    @State private var showAdminPanel: Bool = false
    @State private var wrongPassword: Bool = false
    let correctPassword = "1234" // Senha de administrador

    var body: some View {
        VStack {
            Text("Login do Administrador")
                .font(.title)
                .padding()

            SecureField("Senha", text: $senha)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            if wrongPassword {
                Text("Senha incorreta")
                    .foregroundColor(.red)
                    .padding()
            }

            Button(action: {
                if senha == correctPassword {
                    showAdminPanel = true
                } else {
                    wrongPassword = true
                }
            }) {
                Text("Entrar")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
            .sheet(isPresented: $showAdminPanel) {
                AdminPanelView()
            }
        }
        .padding()
    }
}

// Painel do administrador
struct AdminPanelView: View {
    @State private var cadastros: [[String: String]] = UserDefaults.standard.array(forKey: "cadastros") as? [[String: String]] ?? []
    @State private var showDeleteConfirmation: Bool = false
    @State private var cadastroToDelete: Int?

    var body: some View {
        VStack {
            Text("Painel do Administrador")
                .font(.largeTitle)
                .padding()

            // Indicador de número de cadastros
            Text("Número de pessoas cadastradas: \(cadastros.count)")
                .font(.subheadline)
                .padding(.bottom)

            List {
                ForEach(cadastros.indices, id: \.self) { index in
                    let cadastro = cadastros[index]
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Nome: \(cadastro["nome"] ?? "Desconhecido")")
                            Text("CPF: \(cadastro["cpf"] ?? "Desconhecido")")
                            Text("Residência: \(cadastro["residencia"] ?? "Desconhecido")")
                            Text("Nome da Doação: \(cadastro["nomeDoacao"] ?? "Desconhecido")")
                            Text("Número de Doações: \(cadastro["numDoacoes"] ?? "Desconhecido")")
                        }
                        Spacer()
                        // Ícone de deletar
                        Button(action: {
                            cadastroToDelete = index
                            showDeleteConfirmation = true
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                    .padding()
                }
            }
            .alert(isPresented: $showDeleteConfirmation) {
                Alert(title: Text("Confirmação"),
                      message: Text("Tem certeza que deseja deletar este cadastro?"),
                      primaryButton: .destructive(Text("Deletar")) {
                        if let index = cadastroToDelete {
                            cadastros.remove(at: index)
                            UserDefaults.standard.set(cadastros, forKey: "cadastros")
                            cadastroToDelete = nil // Limpa a referência após a deleção
                        }
                      },
                      secondaryButton: .cancel() {
                        cadastroToDelete = nil // Limpa a referência se cancelado
                      })
            }
        }
        .padding()
    }
}

// ImagePicker para selecionar a foto
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            picker.dismiss(animated: true)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
