
import System.Environment
import System.Posix.Process
import System.Directory
import System.IO.Unsafe
import Data.List

main = do
  True <- doesDirectoryExist "Enqm/API/UnixShell/Generated"
  args <- getArgs
  env  <- getEnvironment
  case lookup "ENQIN" env of
    Just a  -> putStr ("Allready inside enqin " ++ show a ++ "\n")
    Nothing -> executeFile "bash" True args (Just $ foldr (\(a,b) c -> modify a b c) env mods)

curDir :: String
curDir = unsafePerformIO $ getCurrentDirectory

mods =
 [("PS1", \a -> a ++ " enqin> ")
 ,("PATH", \a -> a ++ ":" ++ curDir ++ "/" ++ dir ++ "/bin")
 ,("ENQIN", \_ -> curDir)
 ]

dir = "Enqm/API/UnixShell/Generated"

modify :: String -> (String -> String) -> [(String,String)] -> [(String,String)]
modify key fun [] =  [(key,fun "")]
modify key fun (o@(x,y):xys)
    | key == x  = (x,fun y) : modify key fun xys
    | otherwise = o : modify key fun xys

