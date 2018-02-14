
import System.Environment
import System.Posix.Process

main = do
  True <- doesDirectoryExist "Enqm/API/UnixShell/Generated"
  args <- getArgs
  env  <- getEnvironment
  executeFile "bash" True args (Just $ foldr (\f b -> f b) env mods)

mods =
 [("PS1", \a -> a ++ " enqin> ")
 ,("PATH", \a -> a ++ ":" ++ (unsafePerformIO $ getCurrentDirectory) ++ "/" ++ dir ++ "/bin")
 ]

dir = "Enqm/API/UnixShell/Generated"

modify :: (Eq a) => a -> (b -> b) -> [(a,b)] -> [(a,b)]
modify _ _ [] =  Nothing
modify key fun (o@(x,y):xys)
    | key == x  = (x,fun y) : modify key fun xys
    | otherwise = o : modify key fun xys

