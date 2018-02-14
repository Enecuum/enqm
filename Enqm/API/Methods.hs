{-# LANGUAGE TemplateHaskell #-}

module Enqm.API.Methods where

import System.Random
import Language.Haskell.TH
import Data.Typeable
import Language.Haskell.Meta.Parse

import Enqm.API.Types
import Enqm.API.RPC.Generic

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

listOfAccessFunctions = map (\(a,b) -> (a,parseType $ show b)) $(functionExtractor " Access ")





