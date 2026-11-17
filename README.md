# Sistema de Ponto — Exemplo Colégio e Curso

Aplicação web para rede local, com painel administrativo, cadastro de funcionários, jornadas configuráveis, registro de ocorrências, trilha de auditoria e exportação CSV compatível com Excel.

## Requisitos
- Windows 10/11 ou Linux no computador que será o servidor.
- Python 3.11 ou superior.
- Rede local da escola.

## Instalação (Windows)
1. Instale Python 3.11+ e marque **Add Python to PATH**.
2. Extraia a pasta do projeto.
3. Abra o terminal dentro da pasta `exemplo-ponto`.
4. Execute:

```powershell
python -m venv .venv
.venv\Scripts\activate
pip install -r requirements.txt
$env:ADMIN_USER="admin"
$env:ADMIN_PASSWORD="CrieUmaSenhaForteAqui"
$env:APP_SECRET="COLOQUE_UMA_CHAVE_ALEATORIA_LONGA_AQUI"
uvicorn app.main:app --host 0.0.0.0 --port 8000
```

5. No próprio servidor, abra `http://127.0.0.1:8000/admin`.
6. Em outro dispositivo da rede, abra `http://IP-DO-COMPUTADOR:8000/admin`.
7. A tela de ponto fica em `http://IP-DO-COMPUTADOR:8000/`.

Descubra o IP do servidor no Windows com `ipconfig`. Libere a porta 8000 no Firewall apenas para a rede privada da escola.

## Dados
O banco SQLite é criado em `data/ponto.db`. Faça backup com o serviço parado, copiando a pasta `data`. Para múltiplos usuários em produção, recomenda-se PostgreSQL, HTTPS, backup automático e monitoramento.

## Estado das funcionalidades
- Login administrativo com cookie HttpOnly e senha com hash.
- Cadastro, edição e inativação de funcionários.
- Jornada individual configurável.
- Dashboard básico, listagem de marcações e ocorrências.
- Aprovação/rejeição de justificativas com auditoria.
- Exportação de marcações CSV compatível com Excel.
- Captura de câmera no navegador.

## Bloqueio biométrico intencional
A câmera está acessível, mas o reconhecimento facial **não autentica nem registra ponto nesta versão**. Os endpoints biométricos permanecem bloqueados até integrar um provedor com comparação biométrica no servidor, detecção de vivacidade (anti-spoofing), proteção criptográfica dos templates, gestão de consentimento/base legal e testes de segurança. Não use fotos enviadas pelo navegador nem embeddings calculados apenas no cliente como prova de identidade.

## Antes da implantação oficial
1. Configurar HTTPS (necessário para acesso à câmera em outros dispositivos; `localhost` é exceção).
2. Trocar segredos e senha inicial; restringir firewall e acesso administrativo.
3. Migrar para PostgreSQL se houver uso concorrente relevante.
4. Implementar recuperação de senha, perfis granulares e política de retenção.
5. Validar regras de jornada, convenção coletiva, banco de horas e requisitos aplicáveis ao sistema de registro eletrônico de ponto no Brasil (incluindo avaliação da Portaria MTP 671/2021 e documentação técnica pertinente).
6. Realizar avaliação de impacto e controles LGPD para dados biométricos, que são dados pessoais sensíveis.
7. Validar relatórios e cálculos com o RH/contador antes de uso para folha de pagamento.

Esta entrega é uma base funcional de desenvolvimento, não uma certificação de conformidade trabalhista nem um sistema biométrico pronto para produção.

## Versão com foto (build 0.3)
- A tela de ponto agora funciona assim: o funcionário digita o nome, toca nele e tira uma foto; o ponto é gravado com a foto em `data/photos/AAAA-MM/`.
- No painel admin, aba **Marcações**, o link **Ver foto** abre a foto de cada registro.
- O reconhecimento facial continua bloqueado; a foto serve como evidência, não como autenticação.
- O `requirements.txt` já traz as versões compatíveis com Python 3.14 (SQLAlchemy 2.0.44+ e bcrypt 4.0.1).
- Para iniciar no Windows: dois cliques em `iniciar-windows.bat` (funciona mesmo com espaços no caminho da pasta).
