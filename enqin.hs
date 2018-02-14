
import System.Environment
import System.Posix.Process
import System.Directory
import System.IO.Unsafe
import Data.List

main = do
  args <- getArgs
  env  <- getEnvironment
  case lookup "ENQIN" env of
    Just a  -> do putStr ("Already inside enqin\n" ++ message a ++ "\n")
                  executeFile "ls" True [a ++ "/" ++ dir ++ "/bin"] (Just env)
    Nothing -> do True <- doesDirectoryExist "Enqm/API/UnixShell/Generated"
                  executeFile "bash" True args (Just $ foldr (\(a,b) c -> modify a b c) env mods)

message a = unlines
 ["Program dir: " ++ a
 ]

curDir :: String
curDir = unsafePerformIO $ getCurrentDirectory

mods =
 [("PATH", \a -> a ++ ":" ++ curDir ++ "/" ++ dir ++ "/bin")
 ,("ENQIN", \_ -> curDir)
 ]

dir = "Enqm/API/UnixShell/Generated"

modify :: String -> (String -> String) -> [(String,String)] -> [(String,String)]
modify key fun [] =  [(key,fun "")]
modify key fun (o@(x,y):xys)
    | key == x  = (x,fun y) : xys
    | otherwise = o : modify key fun xys

