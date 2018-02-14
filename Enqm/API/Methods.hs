{-# LANGUAGE TemplateHaskell #-}

module Enqm.API.Methods where

import System.Random
import Language.Haskell.TH
import Data.Typeable

import Enqm.API.Types
import Enqm.API.RPC.Generic


_Access = $(functionExtractor "^[^_].*::.* Access ")
_Enqin  = $(functionExtractor "^[^_].*::.* Enqin " )


enableEnqinCodeAutoreload :: Enqin ()
enableEnqinCodeAutoreload = error "test code autoreload"

jsonRpcPipe :: UnixPipe String -> Enqin String
jsonRpcPipe = error "test json rpc pipe"

data Pongs = Pong PongStatus (Enqin Pongs)
data Terminal = Terminal String (Enqin Terminal)

pingPeer :: Network -> Peer -> Access (Enqin Pongs)
pingPeer = undefined

enqman :: GetOptWith UnixShellCommand -> Enqin Terminal
enqman = undefined

startHttpServer :: Maybe (Control,Maybe HttpListener) -> Access (Control,HttpListener,DefaultHttpServer)
startHttpServer = undefined

startNetwork :: Maybe (Control,Maybe Network) -> Access (Control,Network)
startNetwork = undefined

startMining :: Maybe (Control,Maybe Miner) -> Access (Control,Miner)
startMining = error "mining test"

createWallet :: Maybe (Control,Wallet) -> Access (Control,Wallet)
createWallet = error "wallet test"

createKeyPair :: Maybe Control -> Access (Control,Security KeyPair)
createKeyPair = error "key pair test"

getLocalControl :: Access Control
getLocalControl = undefined

getListOfMiners :: Control -> Access [Miner]
getListOfMiners _ = return []

isPowMining :: Miner -> Access Bool
isPowMining = undefined

getConnectedPeers :: Network -> Access [Peer]
getConnectedPeers = undefined

getBlock :: Storage -> Hash -> Binary
getBlock = undefined


