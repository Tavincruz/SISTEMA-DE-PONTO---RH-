@echo off
setlocal
rem Sempre roda a partir da pasta onde este arquivo esta (aspas = funciona com espacos no caminho)
cd /d "%~dp0"

if not exist "requirements.txt" (
  echo ERRO: requirements.txt nao encontrado nesta pasta. A pasta do projeto esta incompleta.
  pause
  exit /b 1
)

if not exist ".venv\Scripts\activate.bat" (
  where py >nul 2>nul
  if errorlevel 1 (
    python -m venv .venv
  ) else (
    py -3 -m venv .venv
  )
)
if not exist ".venv\Scripts\activate.bat" (
  echo ERRO: nao foi possivel criar o ambiente virtual. Verifique se o Python esta instalado.
  pause
  exit /b 1
)

call ".venv\Scripts\activate.bat"
python -m pip install -r requirements.txt
if errorlevel 1 (
  echo ERRO na instalacao das dependencias.
  pause
  exit /b 1
)

if "%ADMIN_USER%"=="" set ADMIN_USER=admin
if "%ADMIN_PASSWORD%"=="" set ADMIN_PASSWORD=ALTERE-ESTA-SENHA-ANTES-DE-USAR
if "%APP_SECRET%"=="" set APP_SECRET=ALTERE-PARA-UMA-CHAVE-ALEATORIA-LONGA

echo.
echo Painel admin:  http://127.0.0.1:8000/admin
echo Tela de ponto: http://127.0.0.1:8000/
echo Para parar, feche esta janela ou use Ctrl+C.
echo.
uvicorn app.main:app --host 0.0.0.0 --port 8000
pause
