package pool

import (
	"errors"
	"net"
)

// poolConn is a wrapper around net.Conn to modify the the behavior of
// net.Conn's Close() method.
type poolConn struct {
	net.Conn
	c *channelPool
}

// Close() puts the given connects back to the pool instead of closing it.
func (p poolConn) Close() error {
	return p.c.put(p.Conn)
}
func (p poolConn) Purge() error {
	if p.Conn != nil {
		return p.Conn.Close()
	}
	return errors.New("Connection nil")
}

// newConn wraps a standard net.Conn to a poolConn net.Conn.
func (c *channelPool) wrapConn(conn net.Conn) net.Conn {
	p := poolConn{c: c}
	p.Conn = conn
	return p
}
