module Enqm.API.Types where

data Access a
data Storage
data Network
data Control
data Miner
data Peer
data Hash
data Binary

instance Functor Access where
instance Applicative Access where
instance Monad Access where







