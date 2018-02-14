{-# LANGUAGE TemplateHaskell #-}

module Enqm.API.RPC where

import Language.Haskell.TH

import Enqm.API.Types
import Enqm.API.Methods
import Enqm.API.RPC.Generic

$(createAndAssignData "apiRpcMethods" $ concat [_Access])

