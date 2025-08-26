
# 📌 Sistema de Feedback

![GitHub last commit](https://img.shields.io/github/last-commit/SEU_USUARIO/sistema-feedback)
![GitHub issues](https://img.shields.io/github/issues/SEU_USUARIO/sistema-feedback)
![GitHub pull requests](https://img.shields.io/github/issues-pr/SEU_USUARIO/sistema-feedback)
![GitHub](https://img.shields.io/github/license/SEU_USUARIO/sistema-feedback)

Este projeto é um **Sistema de Feedback** desenvolvido na **Salesforce**, que permite coletar, analisar e visualizar feedbacks de clientes utilizando integração com a **API de Sentimento do Google** e componentes **Lightning Web Components (LWC)**.

---

## ✅ Funcionalidades Principais

- **Coleta de Feedback**:
  - Formulário responsivo com:
    - Avaliação (**1 a 5 estrelas**)
    - Categoria (**Produto, Suporte, Entrega**)
    - Comentário
    - E-mail (opcional)
  - Validação em tempo real:
    - Rating obrigatório
    - Comentário mínimo de 10 caracteres
  - Envio com **Spinner** e **Toast de confirmação**

- **Análise de Sentimento**:
  - Integração com **Google Cloud Natural Language API**
  - Atualiza automaticamente o campo **Sentiment__c** com:
    - Positivo
    - Neutro
    - Negativo

- **Dashboard de Insights**:
  - **Gráfico de Sentimentos** (Pizza): % Positivo / Neutro / Negativo
  - **Lista de Feedbacks Críticos** (Negativos) com botão **Criar Caso**
  - **Média por Categoria** (Gráfico de Barras)
  - Filtros por **período (7/30/90 dias)** e **categoria**
  - Implementação via **Chart.js**

- **Automações**:
  - Feedback Positivo (Rating ≥ 4):
    - E-mail de agradecimento com cupom (PDF gerado via Apex)
  - Feedback Negativo:
    - Criação automática de **Caso**
    - Atribuição à fila de **Suporte Crítico**
    - **Notificação em tempo real no Slack**

---

## 🛠️ Tecnologias Utilizadas

- **Salesforce Platform**
  - Apex (Lógica e Integração com API)
  - Lightning Web Components (UI)
  - Flows e Triggers
- **Google Cloud Natural Language API** (Análise de Sentimento)
- **Chart.js** (Gráficos em LWC)
- **Slack API** (Notificações)
- **VS Code + Salesforce CLI**

---

## 📂 Estrutura do Projeto

```
/lwc
  /feedbackForm          # Componente para envio de feedback
  /feedbackDashboard     # Dashboard com gráficos e lista de feedbacks
/apex
  GoogleSentimentService # Classe para integração com API do Google
  FeedbackHelper         # Classe para orquestrar a lógica de atualização
/triggers
  FeedbackTrigger        # Trigger para atualizar sentimento
/tests
  FeedbackHelperTest     # Testes de integração
  GoogleSentimentMock    # Mock para chamadas HTTP
```

---

## 🚀 Como Executar

1. **Clonar o repositório**
   ```bash
   git clone https://github.com/seuusuario/sistema-feedback.git
   cd sistema-feedback
   ```

2. **Autenticar na Salesforce**
   ```bash
   sfdx force:auth:web:login -a DevHub
   ```

3. **Criar um scratch org e instalar os metadados**
   ```bash
   sfdx force:org:create -s -f config/project-scratch-def.json -a feedbackOrg
   sfdx force:source:push
   ```

4. **Definir variáveis de ambiente**
   - Configurar **Chave de API do Google** no Custom Metadata ou Named Credentials.
   - Configurar **Slack Webhook** (opcional).

5. **Abrir org no navegador**
   ```bash
   sfdx force:org:open
   ```

---

## ✅ Testes

- **Cobertura mínima**: 90%
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

## 📌 Roadmap

- [ ] Implementar autenticação OAuth com Google
- [ ] Adicionar suporte a múltiplos idiomas
- [ ] Dashboard com filtros avançados
- [ ] Notificações via Microsoft Teams

---

### ⚠️ **Aviso**
As credenciais do documento original **não devem ser incluídas no repositório público**. Utilize variáveis de ambiente ou Named Credentials.
