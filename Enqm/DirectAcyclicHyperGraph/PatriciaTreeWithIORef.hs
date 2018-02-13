module Enqm.DirectedAcyclicHyperGraph.PatriciaTreeWithIORef where


----------------------------------------------------------------------
-- GRAPH REPRESENTATION
----------------------------------------------------------------------

newtype Gr a b = Gr (GraphRep a b)
#if __GLASGOW_HASKELL__ >= 702
  deriving (Generic)
#endif

type GraphRep a b = IntMap (Context' a b)
type Context' a b = (IntMap [Edge b], a, IntMap [Edge b])

data Edge b = Edge  (IORef b)
            | Hyper (IORef b)

type UGr = Gr () ()

----------------------------------------------------------------------
-- OVERRIDING FUNCTIONS
----------------------------------------------------------------------

{-# RULES
      "insNode/Data.Graph.Inductive.PatriciaTree"  insNode = fastInsNode
  #-}
fastInsNode :: LNode a -> Gr a b -> Gr a b
fastInsNode (v, l) (Gr g) = g' `seq` Gr g'
  where
    g' = IM.insert v (IM.empty, l, IM.empty) g

{-# RULES
      "insEdge/Data.Graph.Inductive.PatriciaTree"  insEdge = fastInsEdge
  #-}
fastInsEdge :: LEdge b -> Gr a b -> Gr a b

fastInsEdge (LEdge (v, w, l)) (Gr g) = g2 `seq` Gr g2
  where
    label = Edge $ unsafePerformIO $ newIORef l

    g1 = IM.adjust addS' v g
    g2 = IM.adjust addP' w g1

    addS' (ps, l', ss) = (ps, l', IM.insertWith addLists w [label] ss)
    addP' (ps, l', ss) = (IM.insertWith addLists v [label] ps, l', ss)

fastInsEdge (LHyper (v, w, l)) (Gr g) = g2 `seq` Gr g2
  where
    label = Hyper $ unsafePerformIO $ newIORef l

    g1 = foldr (\v g  -> IM.adjust addS' v g ) g  v
    g2 = foldr (\w g1 -> IM.adjust addP' w g1) g1 w

    addS' (ps, l', ss) = (ps, l', IM.insertWith addLists w [label] ss)
    addP' (ps, l', ss) = (IM.insertWith addLists v [label] ps, l', ss)




