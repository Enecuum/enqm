module Enqm.ProofOfWork where

class ProofOfWork context pow | pow -> context where

  data Journal               pow
  data JournalRangeReduction pow
  data JournalRange          pow
  data Verification          pow
  data Consensus             pow

  create :: context -> pow NotSolved

  changeRandomGuess :: pow NotSolved -> IO (pow NotSolved)

  solve :: pow NotSolved -> Either (ImposibleToSolve pow) (pow Solved)

  getJournal :: pow Solved -> Journal pow

  getJournalRange :: Journal pow -> JournalRange pow

  reduceJournalRange :: JournalRangeReduction pow -> JournalRange pow -> JournalRange pow

  verifyJournalRange :: Journal pow -> JournalRange -> Bool

  createFinalization :: Verification pow -> pow Solved -> pow NotFinalized

  setConsensusStatus :: Consensus pow -> pow NotFinalized -> pow Finalized



