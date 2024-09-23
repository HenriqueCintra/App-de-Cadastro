# App-de-Cadastro
📱 Projeto - Aplicativo de Cadastro com Foto e Login

Este projeto é um aplicativo desenvolvido em SwiftUI que permite realizar o cadastro de doadores, adicionar uma foto opcional e gerenciar doações. O aplicativo possui um sistema de login para administrador que pode acessar e gerenciar os cadastros.

✨ Funcionalidades

🔐 Tela de Login:
Insira nome e senha para acessar.
Senha padrão: 1234.
📝 Cadastro de Doações:
Informações como Nome, CPF, Residência, Nome da Doação e Número de Ramas Doadas.
Foto opcional: O usuário pode adicionar uma foto da galeria.
🛠️ Administração:
Gerenciamento de cadastros no painel do administrador.
Deletar cadastros diretamente do painel.
📱 Preview

Tela de Login	Tela de Cadastro	Painel do Admin
🚀 Tecnologias Utilizadas

SwiftUI: 🎨 Interface moderna e reativa.
UserDefaults: 💾 Armazenamento local para cadastros.
UIKit (UIImagePicker): 📷 Integração para seleção de fotos da galeria.
State Management: ⚡ Gerenciamento dinâmico de estados.
📖 Como Usar

Login: 🛡️ Na tela inicial, insira qualquer nome e a senha 1234.
Cadastro: ✍️ Preencha os campos e adicione uma foto (opcional).
Clique no botão "Cadastrar" após preencher os dados.
Administração: 👨‍💼 Acesse o painel de admin através do botão "Administrador" e insira a senha 1234.
🛠️ Estrutura do Código

ContentView: 🎯 Exibição principal e navegação.
LoginView: 🔐 Tela de login para o cadastro.
CadastroView: 📝 Formulário de cadastro.
AdminLoginView: 🔑 Gerenciamento de login do administrador.
AdminPanelView: 📊 Painel de cadastros e ações de deletar.
ImagePicker: 📷 Seleção de imagens da galeria com UIKit.
🔮 Melhorias Futuras

🔒 Implementar autenticação segura (OAuth).
✏️ Permitir edição de cadastros.
☁️ Sincronização com backend remoto (ex: Firebase).
🖥️ Requisitos do Sistema

Xcode 12.0+
iOS 14.0+
🤝 Contribuindo

Faça um fork do projeto.
Crie uma branch (git checkout -b feature/sua-feature).
Faça commit das suas alterações (git commit -am 'Adiciona nova feature').
Envie para a branch (git push origin feature/sua-feature).
Abra um Pull Request.
📬 Contato
Desenvolvedor: José Henrique Cintra de Souza Barros
📧 Email: engcomphenrique@gmail.com
