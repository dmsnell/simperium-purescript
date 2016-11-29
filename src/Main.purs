module Main where

import Prelude
import SimperiumTypes as ST
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import SimperiumTypes (Command(..), StreamAtom(..), toStream)

connection :: ST.ConnectionInfo
connection = 
    ST.ConnectionInfo
        (ST.AppId "my-thing")
        (ST.AccessToken "my-token")
        (ST.ApiVersion "1")
        (ST.ClientId "my-app")
        (ST.LibraryName "simperium-purescript")
        (ST.LibraryVersion "0.1.0")

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do
  log "Hello sailor!"
  showStream $ SendHeartbeat 15
  showStream $ ChannelCommand (ST.Channel 0) $ RequestEntity (ST.Key "note-5") (ST.EntityVersion 203)
  showStream $ StopLogging
  showStream $ ChannelCommand (ST.Channel 1) $ ConnectToBucket connection (ST.BucketName "notes") NoOp
    where
      showStream a = log $ show $ toStream a
