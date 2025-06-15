# Etapa de build
FROM golang:alpine AS builder

WORKDIR /app

# Copia o código para dentro do container
COPY main.go .

# Inicializa um módulo Go simples
RUN go mod init fullcycle

# Compila o binário para o sistema operacional Linux
RUN go build -ldflags="-s -w" -o fullcycle

# Etapa final (imagem mínima)
FROM scratch

# Copia apenas o binário gerado
COPY --from=builder /app/fullcycle .

# Comando que será executado
CMD ["./fullcycle"]
