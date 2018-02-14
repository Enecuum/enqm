
import System.Environment
import System.Posix.Process

main = do
  args <- getArgs
  env  <- getEnvironment
  executeFile "bash" True args (Just env)
  print "kuku"

