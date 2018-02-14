{-# LANGUAGE TemplateHaskell #-}

module Enqm.API.Methods where

import System.Random
import Language.Haskell.TH
import Data.Typeable

import Enqm.API.Types
import Enqm.API.RPC.Generic



_Access = $(functionExtractor "^[^_].* Access ")



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


