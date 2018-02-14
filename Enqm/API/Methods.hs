{-# LANGUAGE TemplateHaskell, QuasiQuotes, GADTs, MultiParamTypeClasses, FunctionalDependencies #-}

module Enqm.API.Methods where

import System.Random
import Language.Haskell.TH
import Language.Haskell.TH.Syntax
import Data.Typeable

import Enqm.API.Types
import Enqm.API.RPC.Generic


_Access = $(functionExtractor "^[a-z].*::.* Access ")
_Enqin  = $(functionExtractor "^[a-z].*::.* Enqin " )
_Demo   = $(functionExtractor "^[a-z].*::.* Demo " )
-- _Class  = $(functionExtractor "^[^_].*::.*-- use extractor with class$" )


enableEnqinCodeAutoreload :: Enqin ()
enableEnqinCodeAutoreload = error "test code autoreload"

jsonRpcPipe :: UnixPipe String -> Enqin String
jsonRpcPipe = error "test json rpc pipe"

data Pongs = Pong PongStatus (Enqin Pongs)
data Terminal = Terminal String (Enqin Terminal)

pingPeer :: Network -> Peer -> Access (Enqin Pongs)
pingPeer = undefined

pvcnHashLoop :: Binary -> [Hash] -> Demo [(Hash,Lazy PvcnHashReport)]
pvcnHashLoop = undefined

class GetLazyData t where
  getLazyData :: Lazy a -> t a -- use extractor with class

instance GetLazyData Demo
instance GetLazyData Access
instance GetLazyData Enqin

abc = [| getLazyData |]

enudoc :: GetOptWith UnixShellCommand -> Enqin Terminal
enudoc = undefined

data Trigger a
data SingleProcess a
data SelectedProcesses a
data ExpectedProcesses a

data Enqout mask where
 Enqwait :: (Enqoutable processes mask, SingleProcess     processes ~ mask) => Trigger (Enqin  processes)              -> Enqout mask
 Enqpend :: (Enqoutable processes mask, ExpectedProcesses processes ~ mask) => Trigger (Enqin (processes,Enqout mask)) -> Enqout mask
 Enqout  :: (Enqoutable processes mask, SelectedProcesses processes ~ mask) => processes                               -> Enqout mask

-- = forall processes. (Enqoutable processes mask) => Enqpend (Trigger (Enqin (processes,Enqout mask))) | Enqout processes

class Enqoutable processes mask | processes -> mask where
  _enqout :: Maybe processes -> Enqin (Enqout mask)

-- enqound
-- enqrchive
-- enqtat
-- enqilize
-- enquz
-- enqenate :: Enqout (SelectedProcesses processes) -> Enqin (OfflineTicket processes)
-- enqake :: OfflineTicket processes -> Enqin (OfflineAndReady processes)
-- enqorld :: OfflineAndReady process -> Enqin (Enqout (SelectedProcesses processes))

{-
instance Enqoutable Access (SingleProcess Access) where
  _enqout Nothing = return $ Enqpend $ listeningForNewProcesses :: Enqin (Access,Enqout (SingleProcess Access))
-}

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

getLocalPrivateControl :: Access Control
getLocalPrivateControl = undefined

getLocalRemoteboxControl :: Access Control
getLocalRemoteboxControl = undefined

getDefaultControl :: Access Control
getDefaultControl = undefined

getLocalSandboxControl :: Access Control
getLocalSandboxControl = undefined

getTorPublicControl :: Access Control
getTorPublicControl = undefined

getDirectPublicControl :: Access Control
getDirectPublicControl = undefined

getListOfMiners :: Control -> Access [Miner]
getListOfMiners _ = return []

isPowMining :: Miner -> Access Bool
isPowMining = undefined

getConnectedPeers :: Network -> Access [Peer]
getConnectedPeers = undefined

getBlock :: Storage -> Hash -> Binary
getBlock = undefined


