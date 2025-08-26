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

| Classe                  | Função                                                                     |
|--------------------------|----------------------------------------------------------------------------|
| `GoogleSentimentService`| Integra com API do Google para análise de sentimento                       |
| `FeedbackHelper`        | Orquestra atualização do sentimento e lógicas derivadas                    |

### 🔁 Triggers

| Trigger           | Evento                        | Função                                                           |
|-------------------|-------------------------------|------------------------------------------------------------------|
| `FeedbackTrigger` | after insert, after update    | Chama serviço de sentimento e atualiza campo `Sentiment__c`      |

### 🧪 Testes

| Classe de Teste         | Objetivo                                                             |
|--------------------------|----------------------------------------------------------------------|
| `FeedbackHelperTest`     | Testa lógicas do helper e cobertura de cenários positivos/negativos |
| `GoogleSentimentMock`    | Mock de respostas da API do Google para testes offline              |

---

## 📱 Interface Lightning Customizada

Aplicação configurada com **Lightning App Builder**, oferecendo páginas dedicadas para criação e análise de feedbacks em tempo real.

### 🏠 Página Inicial

- Dashboard com:
  - Gráficos de sentimentos (Chart.js)
  - Feedbacks negativos com botão **Criar Caso**
  - Filtros por data e categoria

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

- **Cobertura**: 100%
- **Cenários**:
  - Análise com feedback positivo, neutro e negativo
  - Trigger em massa com 200 registros
  - Simulação de falha na API

---

## 🔒 Segurança

- Uso de **with sharing** e **SECURITY_ENFORCED** em SOQL
- Tratamento de XSS com `String.escapeSingleQuotes()`
- Proteção de dados sensíveis (API Key via Named Credentials)

---



---

### ⚠️ **Aviso**
As credenciais do documento original **não devem ser incluídas no repositório público**. Utilize variáveis de ambiente ou Named Credentials.
