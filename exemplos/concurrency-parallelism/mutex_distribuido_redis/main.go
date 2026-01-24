package main

import (
	"context"
	"fmt"
	"time"

	redis "github.com/redis/go-redis/v9"
)

type PedidoDeCompra struct {
	Id         string
	Item       string
	Quantidade float64
}

// Função mock para exemplificar a chegada de alguma mensagem
func consomeMensagem() PedidoDeCompra {
	return PedidoDeCompra{
		Id:         "12345",
		Item:       "pão de alho",
		Quantidade: 4,
	}
}

// Função mock para exemplificar o processamento de uma mensagem
func processaMensagem(pedido PedidoDeCompra) bool {
	fmt.Println("Processando pedido:", pedido.Id)
	time.Sleep(10 * time.Second)
	return true
}

func main() {

	var ctx = context.Background()

	// Create a new Redis client
	client := redis.NewClient(&redis.Options{
		Addr:     "0.0.0.0:6379",
		Password: "", // no password set
		DB:       0,  // use default DB
	})

	// looping de consumo
	NovoPedido := consomeMensagem()
	mutexKey := NovoPedido.Id

	fmt.Printf("Tentando adquirir mutex para o recurso: %s\n", mutexKey)

	// Timeout para evitar espera infinita (30 segundos)
	timeout := time.After(30 * time.Second)
	retryCount := 0

	// Loop para aguardar o mutex ser liberado
	for {
		select {
		case <-timeout:
			fmt.Printf("Timeout atingido após 30 segundos aguardando o mutex %s\n", mutexKey)
			return
		default:
		}

		retryCount++

		// Verifica se o Lock já existe
		lock, err := client.Get(ctx, mutexKey).Result()
		if err != nil && err != redis.Nil {
			fmt.Printf("Erro ao verificar existência do mutex %s: %v\n", mutexKey, err)
			time.Sleep(1 * time.Second)
			continue
		}

		if lock != "" {
			fmt.Printf("Mutex travado para o recurso %s, tentativa %d - aguardando liberação...\n", mutexKey, retryCount)
			time.Sleep(2 * time.Second) // Aguarda 2 segundos antes de tentar novamente
			continue
		}

		// Se chegou aqui, o mutex não existe, pode tentar adquiri-lo
		break
	}

	// Loop para tentar adquirir o mutex usando SETNX (SET if Not eXists)
	for {
		// Usa SETNX para garantir atomicidade - só cria se não existir
		success, err := client.SetNX(ctx, mutexKey, "locked", 10*time.Second).Result()
		if err != nil {
			fmt.Printf("Erro ao tentar criar mutex: %v\n", err)
			time.Sleep(1 * time.Second)
			continue
		}

		if success {
			// Mutex criado com sucesso
			fmt.Println("Mutex criado e adquirido para o recurso por 10s:", mutexKey)
			break
		} else {
			// Mutex foi criado por outra thread durante a tentativa
			fmt.Printf("Mutex foi criado por outra thread durante a tentativa, aguardando liberação...\n")
			time.Sleep(2 * time.Second)

			// Verifica se ainda existe
			lock, err := client.Get(ctx, mutexKey).Result()
			if err != nil && err != redis.Nil {
				fmt.Printf("Erro ao verificar existência do mutex: %v\n", err)
				time.Sleep(1 * time.Second)
				continue
			}

			if lock != "" {
				continue // Volta ao início do loop para aguardar
			}
			// Se não existe mais, tenta criar novamente
			continue
		}
	}

	// Processa o registro
	success := processaMensagem(NovoPedido)
	if !success {
		return
	}

	fmt.Println("Pedido processado:", mutexKey)

	// Libera o Mutex
	_, err := client.Del(ctx, mutexKey).Result()
	if err != nil {
		fmt.Printf("Erro ao liberar mutex: %v\n", err)
	} else {
		fmt.Println("Mutex liberado para o recurso:", mutexKey)
	}

}
