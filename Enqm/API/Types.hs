module Enqm.API.Types where

data Access a
data Storage
data Network
data Control
data Miner
data Peer
data Hash
data Binary
data Enqin a
data KeyPair
data Wallet
data Security a

instance Functor Access where
instance Applicative Access where
instance Monad Access where







