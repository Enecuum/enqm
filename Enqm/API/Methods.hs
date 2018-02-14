{-# LANGUAGE TemplateHaskell #-}

module Enqm.API.Methods where

import System.Random
import Language.Haskell.TH
import Data.Typeable

import Enqm.API.Types
import Enqm.API.RPC.Generic


_Access = $(functionExtractor "^[^_].* :: .* Access ")
_Enqin  = $(functionExtractor "^[^_].* :: .* Enqin " )


enableEnqinCodeAutoreload :: Enqin ()
enableEnqinCodeAutoreload = error "test code autoreload"

startMining :: Maybe (Control,Miner) -> Access (Miner,Control)
startMining = error "mining test"

createWallet :: Maybe (Control,Wallet) -> Access (Wallet,Control)
createWallet = error "wallet test"

createKeyPair :: Maybe Control -> Access (Security KeyPair,Control)
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


