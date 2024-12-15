Visão Geral
    Este projeto consiste no desenvolvimento de uma aplicação móvel para gerenciar uma lista de contatos pessoais usando Flutter com um banco de dados SQLite local. A aplicação permite realizar operações CRUD (Create, Read, Update, Delete) em uma tabela de contatos, que contém informações como Nome, Telefone e E-mail.

Estrutura do Projeto

    Diretório Raiz:
        pubspec.yaml - Define as dependências do projeto, incluindo sqflite para o banco de dados SQLite e path_provider para acessar o sistema de arquivos.
        README.md - Documentação básica sobre como configurar e executar o projeto.

    Diretório lib:
        main.dart - Ponto de entrada da aplicação, configurando o MaterialApp e definindo rotas para navegação entre telas.
        models/
            contact.dart - Define a classe Contact para modelar os dados de um contato.
        database/
            database_helper.dart - Classe responsável por operações no banco de dados SQLite (CRUD).
        screens/
            add_contact_screen.dart - Tela para adicionar novos contatos.
            contact_list_screen.dart - Tela para listar e selecionar contatos.
            contact_detail_screen.dart - Tela para visualizar, editar ou excluir detalhes de um contato.

Funcionalidades Implementadas

    Tela de Cadastro (AddContactScreen):

        Permite ao usuário inserir um novo contato via formulário com campos para Nome, Telefone e E-mail.
        Os dados são salvos no banco de dados SQLite ao clicar no botão "Salvar".
        
    Tela de Listagem (ContactListScreen):
        Exibe todos os contatos salvos em uma lista.
        Ao selecionar um contato, o usuário pode visualizar detalhes, editar ou excluir o contato.

    Tela de Detalhes/Edição (ContactDetailScreen):
        Mostra os detalhes do contato selecionado.
        Permite ao usuário editar as informações do contato e salvar as alterações no banco de dados.
        Inclui uma opção para excluir o contato com confirmação do usuário.

Implementação do Banco de Dados

    Banco de Dados SQLite:
        Criação da Tabela: A tabela contacts é criada com colunas id (chave primária, autoincremento), name, phone, e email.
        Operações CRUD:
        Create: Função insert para adicionar novos contatos.
        Read: Função getContacts para recuperar todos os contatos.
        Update: Função update para modificar detalhes de um contato existente.
        Delete: Função delete para remover contatos do banco de dados.

Dependências Utilizadas
    Flutter: Framework para desenvolvimento da aplicação móvel.
    sqflite: Pacote para interação com o banco de dados SQLite em Flutter.
    path_provider: Para obter caminhos de diretório no dispositivo.

Configuração do Ambiente
    Flutter SDK: Instalado e configurado de acordo com a documentação oficial do Flutter.
    Android SDK: Configurado para desenvolvimento Android (não requerido o Android Studio para este projeto, mas pode ser usado).
    Configuração do Projeto: Variáveis de ambiente como ANDROID_HOME e JAVA_HOME configuradas para o ambiente de desenvolvimento.

Execução do Projeto

    Dispositivo Físico ou Emulador: 
        Conecte um dispositivo físico Android ou inicie um emulador.
        No terminal, navegue até o diretório do projeto e execute flutter run.

Conclusão e Desafios Enfrentados
    Conclusão: A aplicação foi bem-sucedida em implementar as operações básicas de CRUD para gerenciamento de contatos, oferecendo uma interface intuitiva e funcional.

Desafios:
    Configuração do ambiente para desenvolvimento Android sem Android Studio.
    Resolução de erros relacionados ao Gradle e JDK durante a compilação.
    Gerenciamento de estado para garantir que a lista de contatos se atualize após operações CRUD.