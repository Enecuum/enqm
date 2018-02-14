{-# LANGUAGE TemplateHaskell, DeriveGeneric #-}

module Enqm.API.RPC where

import Language.Haskell.TH
import Data.Typeable
import GHC.Generics
-- import Type.Reflection

import Enqm.API.Types
import Enqm.API.Methods
import Enqm.API.RPC.Generic

$(createAndAssignData "apiRpcMethods" $ concat [_Access])

