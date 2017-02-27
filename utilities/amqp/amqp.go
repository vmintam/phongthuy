package amqputil

import (
	"muvik/utilities/logging"
	"sync"

	"github.com/streadway/amqp"
)

func makeRabbitmqConChan(amqp_uri string) (*amqp.Connection, *amqp.Channel, error) {
	conn, err := amqp.Dial(amqp_uri)
	if err != nil {
		return nil, nil, err
	}
	ch, err := conn.Channel()
	if err != nil {
		conn.Close()
		return nil, nil, err
	}
	return conn, ch, nil
}

func core_consumer(wg *sync.WaitGroup, amqp_uri string, queue_name string, process func(body []byte) bool) {
	defer wg.Done()
	conn, ch, err := makeRabbitmqConChan(amqp_uri)
	if err != nil {
		logging.Error("%s", err)
		return
	}
	defer conn.Close()
	defer ch.Close()

	msgs, err := ch.Consume(queue_name, "", false, false, false, false, nil)
	if err != nil {
		conn, ch, err = makeRabbitmqConChan(amqp_uri)
		ch.QueueDeclare(queue_name, true, false, false, false, nil)
		msgs, err = ch.Consume(queue_name, "", false, false, false, false, nil)
		if err != nil {
			logging.Error("%s", err)
			return
		}
	}
	var msg amqp.Delivery

	for msg = range msgs {
		err = msg.Ack(process(msg.Body))
		if err != nil {
			logging.Error("%s", err)
			ch.Close()
			conn.Close()
			conn, ch, err = makeRabbitmqConChan(amqp_uri)
			msgs, err = ch.Consume(queue_name, "", false, false, false, false, nil)
		}
	}
}
func MakeConsumer(wait *sync.WaitGroup, amqp_uri string, queue_name string, process func(body []byte) bool) {

	defer wait.Done()
	wg := &sync.WaitGroup{}
	for {
		wg.Add(1)
		go core_consumer(wg, amqp_uri, queue_name, process)
		wg.Wait()
	}
}
func core_producer(wg *sync.WaitGroup, amqp_uri, exchange, key string, inchan <-chan []byte) {

	defer wg.Done()

	conn, err := amqp.Dial(amqp_uri)
	if err != nil {
		logging.Error("%s", err)
		return
	}
	defer conn.Close()
	ch, err := conn.Channel()
	if err != nil {
		logging.Error("%s", err)
		return
	}
	defer ch.Close()

	if exchange == "" {
		_, err = ch.QueueDeclare(key, true, false, false, false, nil)
		if err != nil {
			conn, ch, err = makeRabbitmqConChan(amqp_uri)
		}
	}
	for msg := range inchan {
		if err = ch.Publish(exchange, key, false, false, amqp.Publishing{ContentType: "text/plain", Body: msg}); err != nil {
			logging.Info("Error :%v", err)
			return
		}
	}

}
func MakeProducer(wait *sync.WaitGroup, amqp_uri string, exchange string, key string, inchan <-chan []byte) {
	defer wait.Done()
	wg := &sync.WaitGroup{}

	for {
		wg.Add(1)
		go core_producer(wg, amqp_uri, exchange, key, inchan)
		wg.Wait()
	}

}
