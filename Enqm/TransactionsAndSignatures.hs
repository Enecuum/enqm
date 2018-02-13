{-# LANGUAGE GADTs #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeFamilies #-}

module Enqm.TransactionsAndSignatures where

data Transaction pubk amot result where -- Vertex of graph
  SendAmountFromKeyToKey :: { owner :: pubk, receiver :: pubk, amount :: amot } -> Transaction pubk amot ()

data Signature sign result where -- Edge of graph

