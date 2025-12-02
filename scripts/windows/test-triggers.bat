@echo off
REM Tenta Git Bash
set GITBASH="C:\Program Files\Git\bin\bash.exe"
if exist %GITBASH% (
    echo 🔄 Executando test-triggers.sh via Git Bash...
    %GITBASH% ./scripts/linux/test-triggers.sh %*
    exit /b %ERRORLEVEL%
)

echo ❌ Nenhum ambiente Bash encontrado (WSL ou Git Bash).
echo Instale WSL ou Git Bash para rodar este projeto.
exit /b 1
