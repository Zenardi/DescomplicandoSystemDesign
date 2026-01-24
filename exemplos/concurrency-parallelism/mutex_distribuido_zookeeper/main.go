package main

import (
	"fmt"
	"time"

	"github.com/go-zookeeper/zk"
)

type PedidoDeCompra struct {
	Id         string
	Item       string
	Quantidade float64
}

// Função mock para exemplificar a chegada de alguma mensagem
func consomeMensagem() PedidoDeCompra {
	return PedidoDeCompra{
		Id:         "123456",
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

	// Conecta ao ZooKeeper
	conn, _, err := zk.Connect([]string{"0.0.0.0"}, 1000*time.Second)
	if err != nil {
		panic(err)
	}
	defer conn.Close()

	// looping de consumo
	NovoPedido := consomeMensagem()
	mutexKey := fmt.Sprintf("/%v", NovoPedido.Id)

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

		// Verifica se o Znode de lock já existe
		exists, _, err := conn.Exists(mutexKey)
		if err != nil {
			fmt.Printf("Erro ao verificar existência do mutex %s: %v\n", mutexKey, err)
			time.Sleep(1 * time.Second)
			continue
		}

		if exists {
			fmt.Printf("Mutex travado para o recurso %s, tentativa %d - aguardando liberação...\n", mutexKey, retryCount)
			time.Sleep(2 * time.Second) // Aguarda 2 segundos antes de tentar novamente
			continue
		}

		// Se chegou aqui, o mutex não existe, pode tentar adquiri-lo
		break
	}

	// Tentativa de criar o lock para o registro
	acl := zk.WorldACL(zk.PermAll) // Permissões abertas, ajuste conforme necessário
	var path string

	// Loop para tentar adquirir o mutex
	for {
		var err error
		path, err = conn.Create(mutexKey, []byte{}, zk.FlagEphemeral, acl)
		if err != nil {
			if err == zk.ErrNodeExists {
				fmt.Printf("Mutex foi criado por outra thread durante a tentativa, aguardando liberação...\n")
				time.Sleep(2 * time.Second)

				// Verifica novamente se ainda existe
				exists, _, existsErr := conn.Exists(mutexKey)
				if existsErr != nil {
					fmt.Printf("Erro ao verificar existência do mutex: %v\n", existsErr)
					time.Sleep(1 * time.Second)
					continue
				}

				if exists {
					continue // Volta ao início do loop para aguardar
				}
				// Se não existe mais, tenta criar novamente
				continue
			}
			// Outro tipo de erro
			fmt.Printf("Erro ao criar mutex: %v\n", err)
			time.Sleep(1 * time.Second)
			continue
		}

		// Mutex criado com sucesso
		break
	}

	fmt.Println("Mutex criado e adquirido para o recurso", mutexKey)

	// Processa o registro
	success := processaMensagem(NovoPedido)
	if !success {
		return
	}

	fmt.Println("Pedido processado:", mutexKey)

	// Libera o Mutex manualmente
	conn.Delete(path, -1)
	fmt.Println("Mutex liberado para o recurso:", mutexKey)

	// Caso a sessão com o zookeeper acabe, todos os locks gerados pela conexão serão liberados.
	time.Sleep(50 * time.Second)
}
