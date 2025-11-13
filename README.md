![](./image.png)

[**Cleuton Sampaio**](https://linkedin.com/in/cleutonsampaio)

# Elxir? Anyone? 

## Guia Rápido Elixir + Phoenix (API REST básica)

Este é um guia simples para criar uma API REST usando **Elixir** e **Phoenix**, desde a instalação até um endpoint funcional retornando JSON. Neste caso, eu já criei a aplicação, mas se você quiser criar uma app sua, siga esse guia. Se quiser só rodar: 



## 1. Instalação do Elixir e Erlang

Siga as instruções oficiais de instalação conforme seu sistema operacional.

**Sistemas com Bash**

```shell
curl -fsSO https://elixir-lang.org/install.sh
sh install.sh elixir@1.19.2 otp@28.1
installs_dir=$HOME/.elixir-install/installs
export PATH=$installs_dir/otp/28.1/bin:$PATH
export PATH=$installs_dir/elixir/1.19.2-otp-28/bin:$PATH
``` 

Verifique se tudo está ok:

```bash
elixir -v
```

Phoenix 1.7+ requer Elixir 1.15+ e Erlang/OTP 24+.

## 2. Instalar o gerador Phoenix

```bash
mix local.hex
mix archive.install hex phx_new
```

## 3. Criar o projeto Phoenix

```bash
mix phx.new hello_api
cd hello_api
mix ecto.create   # opcional só se quiser usar database (nesse caso não usamos)
```

## 4. Rodar o servidor

```bash
mix phx.server
# ou
iex -S mix phx.server
```

Acesse:
[http://localhost:4000](http://localhost:4000)

## 5. Criar a rota da API

Edite `lib/hello_api_web/router.ex` e adicione:

```elixir
scope "/api", HelloApiWeb do
  pipe_through :api

  get "/ping", PingController, :index
end
```

O pipeline `:api` já existe por padrão e aceita JSON.

## 6. Criar o controller

Crie o arquivo:

`lib/hello_api_web/controllers/ping_controller.ex`

Conteúdo:

```elixir
defmodule HelloApiWeb.PingController do
  use HelloApiWeb, :controller

  def index(conn, _params) do
    json(conn, %{status: "ok", message: "pong"})
  end
end
```

## 7. Testar o endpoint

```bash
curl http://localhost:4000/api/ping
```

Resposta esperada:

```json
{"status":"ok","message":"pong"}
```

Pronto: sua primeira API Phoenix funcionando.

Claro. Vou explicar **exatamente a aplicação que criamos**, de forma clara, simples e direta, como se fosse uma visão geral para um curso.

## Mas que ca... nós criamos? 

Calma! Essa app é um **projeto Phoenix mínimo**, cujo objetivo é **expor um endpoint REST** que retorna JSON.

Ela não usa banco de dados, não tem páginas HTML e não possui lógica de negócio complexa.
É um exemplo de **API pura**.

## Arquitetura em 3 minutos

A aplicação Phoenix segue essa estrutura conceitual:

* **Router**: define rotas e aponta para controllers.
* **Controller**: recebe a request, processa a lógica e devolve resposta.
* **Endpoint**: faz a ponte entre HTTP ↔ Phoenix, gerenciando plugs.
* **Sem banco**: nenhum schema, migration ou Ecto está sendo usado.

Ou seja, é Phoenix funcionando como um **microframework de API JSON**, semelhante ao Express.js, Flask ou FastAPI.

# O que exatamente criamos

### 1. Um novo projeto Phoenix chamado `hello_api`

Esse projeto é gerado via:

```bash
mix phx.new hello_api
```

Ele cria toda a estrutura básica do Phoenix.

### 2. Um pipeline de API (já existente)

No arquivo `router.ex`, já existe esse trecho:

```elixir
pipeline :api do
  plug :accepts, ["json"]
end
```

Isso diz ao Phoenix:

> “Requests dentro deste pipeline só aceitam JSON”.

### 3. Um **escopo** `/api`

Adicionamos isso ao router:

```elixir
scope "/api", HelloApiWeb do
  pipe_through :api

  get "/ping", PingController, :index
end
```

Isso significa:

> “Qualquer requisição GET em /api/ping será atendida pelo método `index` do `PingController`.”

### 4. Criamos o **controller** PingController

Arquivo:
`lib/hello_api_web/controllers/ping_controller.ex`

Código:

```elixir
defmodule HelloApiWeb.PingController do
  use HelloApiWeb, :controller

  def index(conn, _params) do
    json(conn, %{status: "ok", message: "pong"})
  end
end
```

Aqui está o coração da aplicação:

* Recebe a request.
* Ignora os parâmetros (`_params`).
* Devolve um JSON simples.

### 5. O comportamento final

Quando você acessa:

```
GET http://localhost:4000/api/ping
```

Recebe:

```json
{
  "status": "ok",
  "message": "pong"
}
```

Esse é o endpoint REST.

# **O que a aplicação NÃO faz**

* Não salva dados.
* Não lê banco.
* Não usa Ecto.
* Não usa HTML, assets, templates.
* Não tem autenticação.
* Não tem estrutura de domínio complexa.

Ela é apenas um **REST endpoint simples** em Phoenix.

# **Para que isso serve?**

* Entender a estrutura mínima de uma API Phoenix.
* Servir como base para algo maior (CRUD, JWT auth, GraphQL, WebSockets).
* Ensinar rotas, controllers e responses JSON.
* Testar se Phoenix está instalado corretamente.

## Limpar build e/ou dependências

Para limpar os artefatos de build: 

```shell
mix clean
```

Para limpar as dependências baixadas: 

```shell
mix deps.clean --all
``` 

Para limpar ambos: 

```shell
mix clean && mix deps.clean --all
```

## Baixar dependêncais e fazer build

Se você quer baixar as dependências e dar um build (após clonar o projeto): 

```shell
mix deps.get && mix compile
```