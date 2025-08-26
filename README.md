# 📝 Sistema de Feedback - Salesforce

Aplicação desenvolvida com **Lightning Web Components (LWC)** e **Apex**, hospedada na plataforma **Salesforce**, para **coleta e análise de feedbacks de clientes**, com integração à **Google Cloud Natural Language API** e automações para gerenciamento de satisfação.

> 💡 Projeto focado em boas práticas de desenvolvimento na Salesforce, com lógica desacoplada, testes automatizados e uso de Named Credentials para segurança de integrações.

---

## 🚀 Funcionalidades Principais

- 🌟 **Formulário de Feedback**
  - Avaliação de 1 a 5 estrelas
  - Categoria do feedback: Produto, Suporte ou Entrega
  - Comentário com mínimo de 10 caracteres
  - E-mail (opcional)
  - Toast de confirmação e spinner de carregamento

- 🧠 **Análise de Sentimento**
  - Integração com **Google Natural Language API**
  - Classificação automática do sentimento:
    - Positivo
    - Neutro
    - Negativo

- 📊 **Dashboard de Insights**
  - Gráfico de Pizza: Distribuição de sentimentos
  - Lista de feedbacks negativos com botão **Criar Caso**
  - Gráfico de barras com média por categoria
  - Filtros por período: 7, 30 ou 90 dias

- ⚙️ **Automações Inteligentes**
  - Feedback positivo (★ 4 ou 5): Envio de e-mail com cupom em PDF
  - Feedback negativo: Criação automática de **Case** e notificação via **Slack**

---

## 🧑‍💻 Tecnologias Utilizadas

- Salesforce Lightning Web Components (LWC)
- Apex (integrações, lógica, triggers)
- Google Cloud Natural Language API
- Chart.js para gráficos em LWC
- Slack API para notificações
- Salesforce CLI + VS Code

---

## 📁 Estrutura do Projeto

### 📦 Lightning Web Components (LWC)

| Componente            | Descrição                                                       |
|------------------------|-----------------------------------------------------------------|
| `feedbackForm`         | Formulário de envio de feedback com validações                 |
| `feedbackDashboard`    | Visualização de insights e gráficos com filtros                |

### ⚙️ Classes Apex

| Classe                   | Função                                                                     |
|--------------------------|----------------------------------------------------------------------------|
| `GoogleSentimentService` | Integra com API do Google para análise de sentimento                       |
| `FeedbackHelper`         | Orquestra atualização do sentimento e lógicas derivadas                    |

### 🔁 Triggers

| Trigger            | Evento                        | Função                                                           |
|--------------------|-------------------------------|------------------------------------------------------------------|
| `FeedbackTrigger`  | after insert, after update    | Chama serviço de sentimento e atualiza campo `Sentiment__c`      |

### 🧪 Testes

| Classe de Teste        | Objetivo                                                             |
|------------------------|----------------------------------------------------------------------|
| `FeedbackHelperTest`   | Testa lógicas do helper e cobertura de cenários positivos/negativos |
| `GoogleSentimentMock`  | Mock de respostas da API do Google para testes offline              |

---

## 📱 Interface Lightning Customizada

Aplicação configurada com **Lightning App Builder**, oferecendo páginas dedicadas para criação e análise de feedbacks em tempo real.

### 🏠 Página Inicial

- Dashboard com:
  - Gráficos de sentimentos (Chart.js)
  - Feedbacks negativos com botão **Criar Caso**
  - Filtros por data e categoria

###

## ✨ Componentes Principais

| Componente | Descrição | Preview |
|------------|-----------|---------|
| `feedbackForm` | Formulário de coleta de feedbacks | ![Feedback Form](<img width="602" height="339" alt="image" src="https://github.com/user-attachments/assets/54109b58-ab3d-43ad-99b5-16165431829b" />
) |
| `feedbackList` | Lista de feedbacks com filtros | ![Feedback List](<img width="618" height="560" alt="image" src="https://github.com/user-attachments/assets/0b60c4b1-aa61-4c4f-977d-a371783e142f" />
) |
| `feedbackDashboard` | Dashboard analítico | ![Dashboard](<img width="1209" height="624" alt="image" src="https://github.com/user-attachments/assets/75ec2b66-d161-475b-816d-1864da36faa9" />
) |

### 📄 Página de Detalhes do Feedback

- Layout otimizado para leitura rápida
- Exibição de sentimento classificado e dados completos do cliente

---

## 🧪 Cobertura de Testes

| Métrica              | Valor          |
|----------------------|----------------|
| Cobertura mínima     | ≥ 90%          |
| Tipos de teste       | Unitário e integração |
| Cenários abrangidos  | Casos positivos, neutros, negativos e falha na API |

---

## ⚙️ Como Executar

Este projeto deve ser hospedado em uma **org Salesforce**.

### 🚧 Pré-requisitos

- Ter **Salesforce CLI** e **VS Code** instalados
- Conta no **Google Cloud** com a **API Natural Language** ativada
- Webhook configurado no **Slack** (opcional)

### Passo a Passo

```bash
# 1. Clone o repositório
git clone https://github.com/seuusuario/sistema-feedback.git
cd sistema-feedback

# 2. Autentique-se na sua org Salesforce (alias: feedbackOrg)
sfdx auth:web:login -a feedbackOrg

# 3. Crie um scratch org e instale os metadados
sfdx force:org:create -s -f config/project-scratch-def.json -a feedbackOrg
sfdx force:source:push

# 4. Abra a org no navegador
sfdx force:org:open

```
---

## ✅ Testes

- **Cobertura:** 100%
- **Cenários:**
  - Análise com feedback positivo, neutro e negativo
  - Trigger em massa com 200 registros
  - Simulação de falha na API

---

## 🔒 Segurança

- Uso de `with sharing` e `SECURITY_ENFORCED` em SOQL
- Tratamento de XSS com `String.escapeSingleQuotes()`
- Proteção de dados sensíveis (API Key via Named Credentials)

---

## 📌 Como Executar

Este projeto deve ser hospedado em uma **org Salesforce**.

---

## ⚙️ Configuração Prévia Obrigatória

Este projeto depende criticalmente da existência do objeto personalizado `Feedback` e seus campos específicos. Execute os passos abaixo **antes** de fazer o deploy do código.

### Passo 1: Criar o Objeto Personalizado "Feedback"

Acesse:

Setup → Object Manager → Create → Custom Object

Configure o objeto com:

- **Label:** Feedback
- **Plural Label:** Feedbacks
- **Object Name:** Feedback

Marque as opções:

- ✅ Enable History Tracking  
- ✅ Allow Reports  
- ✅ Allow Activities  

---

### Passo 2: Criar Campos Customizados no Objeto Feedback

| Label          | API Name           | Tipo              | Detalhes                                | Obrigatório |
|----------------|--------------------|-------------------|-----------------------------------------|-------------|
| Rating         | `Rating__c`        | Number (3, 1)     | Avaliação de 1 a 5 estrelas             | Sim         |
| Comment        | `Comment__c`       | Text Area (Long)  | Comentário do cliente                   | Não         |
| Category       | `Category__c`      | Picklist          | Valores: Product, Support, Delivery     | Não         |
| Sentiment      | `Sentiment__c`     | Picklist          | Valores: Positive, Neutral, Negative    | Não         |
| Contact Email  | `ContactEmail__c`  | Email             | E-mail para contato                     | Não         |

---

### Configuração dos Campos de Lista de Seleção

#### Para `Category__c`:

**Valores da picklist:**

- Product (Produto)
- Support (Suporte)
- Delivery (Entrega)

#### Para `Sentiment__c`:

**Valores da picklist:**

- Positive (Positivo)
- Neutral (Neutro)
- Negative (Negativo)

---

### Passo 3: Configurar Layouts e Permissões

- Adicione **todos os campos** ao layout de página do objeto `Feedback`
- Configure as **permissões de campo** para os perfis apropriados
- Adicione o objeto `Feedback` aos **aplicativos desejados**

---

## 🚀 Instalação e Deploy

Após confirmar que **todos os campos e picklists** foram criados corretamente, execute:

```bash
# 1. Clone o repositório
git clone https://github.com/mtfreitas-dev/SystemFeedbacks.git
cd SystemFeedbacks

# 2. Autentique-se na sua org Salesforce
sfdx auth:web:login -s -a myOrg

# 3. Realize o deploy dos metadados
sfdx force:source:deploy -p ./force-app/main/default -u myOrg

 ```

## 🔐 Permissões Pós-Instalação

- Atribua os **Permission Sets** aos usuários finais
- Verifique permissões de **objeto e campo** para cada perfil
- Configure **sharing rules** se necessário

---

## ❌ Solução de Problemas Comuns

### Erro: `"No such column 'Rating__c' on entity 'Feedback__c'"`

- **Causa:** O campo `Rating__c` não foi criado.
- **Solução:** Volte ao **Passo 2** e crie todos os campos corretamente.

---

### Erro: `"Invalid picklist value: Product in field: Category__c"`

- **Causa:** O valor `Product` não existe na picklist do campo `Category__c`.
- **Solução:** Edite a picklist e adicione os valores faltantes.

---

### App não funciona após instalação

- **Causa:** Permissões insuficientes para o objeto ou campos.
- **Solução:** Verifique e ajuste as **permissões de objeto e campo** nos perfis ou permission sets.

---

### Erro: `"sObject type 'Feedback__c' is not supported"`

- **Causa:** O objeto `Feedback__c` não foi criado ou não está visível para o usuário.
- **Solução:** Verifique se:
  - O objeto foi **criado corretamente**
  - Está **incluído nos aplicativos apropriados**
  - O perfil do usuário tem **acesso de leitura/escrita**


