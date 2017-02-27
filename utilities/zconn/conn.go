package zconn

import (
	"github.com/garyburd/redigo/redis"
	"net"
	"time"
)

var (
	DefaultTimeout        time.Duration = 15 * time.Second
	DefaultMaximumRetries               = 5
)

func ConnectWithTimeout(proto string, host string, timeout time.Duration, retries int) func() (net.Conn, error) {
	return func() (net.Conn, error) {
		var (
			conn net.Conn
			err  error
		)
		for i := 0; i < retries; i++ {
			if timeout > 0 {
				conn, err = net.DialTimeout(proto, host, timeout)
			} else {
				conn, err = net.Dial(proto, host)
			}

			if err == nil {
				return conn, err
			}
		}
		return conn, err
	}
}
func ConnectListWithTimeout(proto string, hosts []string, timeout time.Duration, retries int) func() (net.Conn, error) {
	return func() (net.Conn, error) {
		var (
			conn net.Conn
			err  error
		)
		for _, host := range hosts {
			for i := 0; i < retries; i++ {
				if timeout > 0 {
					conn, err = net.DialTimeout(proto, host, timeout)
				} else {
					conn, err = net.Dial(proto, host)
				}

				if err == nil {
					return conn, err
				}

			}
		}
		return conn, err
	}
}
func ConnectTcp(host string) func() (net.Conn, error) {
	return ConnectWithTimeout("tcp", host, DefaultTimeout, DefaultMaximumRetries)
}
func ConnectUpd(host string) func() (net.Conn, error) {
	return ConnectWithTimeout("udp", host, DefaultTimeout, DefaultMaximumRetries)
}
func ConnectTcpHosts(hosts []string) func() (net.Conn, error) {
	return ConnectListWithTimeout("tcp", hosts, DefaultTimeout, DefaultMaximumRetries)
}
func ConnectUdpHosts(hosts []string) func() (net.Conn, error) {
	return ConnectListWithTimeout("udp", hosts, DefaultTimeout, DefaultMaximumRetries)
}
func RedisConnectTimeout(proto, host string, timeout time.Duration, tries int) func() (redis.Conn, error) {
	return func() (redis.Conn, error) {
		var (
			conn redis.Conn
			err  error
		)
		for i := 0; i < tries; i++ {
			if timeout > 0 {
				conn, err = redis.DialTimeout(proto, host, timeout, 0, 0)
			} else {
				conn, err = redis.Dial(proto, host)
			}
			if err == nil {
				return conn, err
			}
		}
		return nil, err
	}
}

func RedisConnect(proto, host string) func() (redis.Conn, error) {
	return RedisConnectTimeout(proto, host, DefaultTimeout, DefaultMaximumRetries)
}
