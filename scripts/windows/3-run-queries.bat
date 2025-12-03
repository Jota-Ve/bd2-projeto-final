@echo off
REM Tenta Git Bash
set GITBASH="C:\Program Files\Git\bin\bash.exe"
if exist %GITBASH% (
    echo Executando 3-run-queries.sh via Git Bash...
    %GITBASH% ./scripts/linux/3-run-queries.sh %*
    exit /b %ERRORLEVEL%
)

echo ❌ Nenhum ambiente Bash encontrado (WSL ou Git Bash).
echo Instale WSL ou Git Bash para rodar este projeto.
exit /b 1
