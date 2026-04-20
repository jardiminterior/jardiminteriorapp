# vendor/fetch.ps1 — baixa React 18 + ReactDOM 18 + Babel Standalone 7.23.10
# Roda no Windows sem dependências. Execucao:
#   Abrir PowerShell nesta pasta e rodar:  .\fetch.ps1
# OU:
#   Botao direito no arquivo > "Executar com PowerShell"
#
# Apos rodar com internet uma vez, o jardim-interior-prototipo.html
# abre 100% offline (inclusive como PWA instalado).

$ErrorActionPreference = "Stop"
Set-Location -Path $PSScriptRoot

$libs = @(
    @{ Name = "react.development.js";     Url = "https://unpkg.com/react@18.2.0/umd/react.development.js" },
    @{ Name = "react-dom.development.js"; Url = "https://unpkg.com/react-dom@18.2.0/umd/react-dom.development.js" },
    @{ Name = "babel.min.js";             Url = "https://unpkg.com/@babel/standalone@7.23.10/babel.min.js" }
)

# Fallback CDNs se unpkg estiver bloqueado
$fallbacks = @{
    "react.development.js"     = @("https://cdn.jsdelivr.net/npm/react@18.2.0/umd/react.development.js",
                                   "https://cdnjs.cloudflare.com/ajax/libs/react/18.2.0/umd/react.development.min.js")
    "react-dom.development.js" = @("https://cdn.jsdelivr.net/npm/react-dom@18.2.0/umd/react-dom.development.js",
                                   "https://cdnjs.cloudflare.com/ajax/libs/react-dom/18.2.0/umd/react-dom.development.min.js")
    "babel.min.js"             = @("https://cdn.jsdelivr.net/npm/@babel/standalone@7.23.10/babel.min.js")
}

foreach ($lib in $libs) {
    $name = $lib.Name
    $url  = $lib.Url
    Write-Host "-> baixando $name ..." -ForegroundColor Cyan

    $ok = $false
    try {
        Invoke-WebRequest -Uri $url -OutFile $name -UseBasicParsing -TimeoutSec 30
        $ok = $true
    } catch {
        Write-Host "  unpkg falhou, tentando fallbacks..." -ForegroundColor Yellow
        foreach ($fallbackUrl in $fallbacks[$name]) {
            try {
                Invoke-WebRequest -Uri $fallbackUrl -OutFile $name -UseBasicParsing -TimeoutSec 30
                $ok = $true
                Write-Host "  ok via $fallbackUrl" -ForegroundColor Green
                break
            } catch {
                Write-Host "  falhou: $fallbackUrl" -ForegroundColor DarkYellow
            }
        }
    }

    if (-not $ok) {
        Write-Host "ERRO: nao consegui baixar $name de nenhuma fonte." -ForegroundColor Red
        Write-Host "Verifique sua conexao ou firewall corporativo." -ForegroundColor Red
        exit 1
    }
}

Write-Host ""
Write-Host "pronto. tamanhos:" -ForegroundColor Green
Get-ChildItem react.development.js, react-dom.development.js, babel.min.js |
    ForEach-Object { "  {0,8:N0} KB  {1}" -f ($_.Length / 1024), $_.Name }
Write-Host ""
Write-Host "agora o jardim abre offline. Abra jardim-interior-prototipo.html sem internet para testar." -ForegroundColor Green
