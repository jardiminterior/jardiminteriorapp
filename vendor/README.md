# vendor/ — dependências locais para modo offline

O `jardim-interior-prototipo.html` foi desenhado para funcionar **sem
internet** depois do primeiro setup. Para isso, ele precisa de três
bibliotecas UMD nesta pasta:

- `react.development.js` (~1 MB)
- `react-dom.development.js` (~1 MB)
- `babel.min.js` (~3 MB)

Total: ~5 MB. Ficam na pasta, servidos como arquivos estáticos.

## Como popular esta pasta

### Windows (mais fácil)

Duplo clique em **`fetch.bat`**. Ele invoca o PowerShell com
`-ExecutionPolicy Bypass` e baixa tudo. Pausa no final para você ler
o log.

### Mac / Linux

```bash
cd vendor
bash fetch.sh
```

### O que os scripts fazem

Baixam os três UMDs das versões exatas (React 18.2.0, Babel Standalone
7.23.10). Tentam primeiro `unpkg.com`; se falhar (firewall corporativo,
ISP), caem em `cdn.jsdelivr.net` e `cdnjs.cloudflare.com`.

## Como o HTML decide entre local e CDN

O loader do `jardim-interior-prototipo.html` tenta, em ordem, para
cada lib: `./vendor/*.js` → `unpkg.com` → `jsdelivr.net` →
`cdnjs.cloudflare.com`. Primeiro que funcionar vence. Se todos
falharem, a UI mostra a mensagem "o jardim precisa de conexão" com
instruções de como rodar o script de fetch.

Ou seja: o repositório pode ser distribuído **com ou sem** a pasta
vendor populada. Com ela, funciona offline. Sem ela, funciona online.

## Para distribuir como PWA (piloto)

Depois de rodar `fetch.sh`, copie para hosting estático (GitHub Pages,
Netlify drop, S3…) o arquivo HTML + `manifest.json` + ícones + a pasta
`vendor/`. Funcionará offline e instalável.

## Licenças

- React: MIT (Meta Platforms)
- React DOM: MIT (Meta Platforms)
- Babel Standalone: MIT (The Babel Authors)

Incluídos como dependências no hosting estático. Não redistribuídos
como parte do produto.
