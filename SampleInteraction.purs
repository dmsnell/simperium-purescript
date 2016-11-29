module SampleInteraction where

import Prelude
import SimperiumTypes
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Data.Unit (Unit)

send :: Command -> Boolean
send a = true

receive :: Mesage
receive = ReceiveHeartbeat 1

connection :: ConnectionInfo
connection = 
    ConnectionInfo
        (AppId "my-thing")
        (AccessToken "my-token")
        (ApiVersion "1")
        (ClientId "my-app")
        (LibraryName "simperium-purescript")
        (LibraryVersion "0.1.0")

handleMessage :: Message -> Command
handleMessage m = NoOp

dispatchLoop :: Unit
dispatchLoop = do
  message <- receive
  command <- handleMessage message
  send command
  dispatchLoop

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do
  log $ show $ send $ ConnectToBucket connection (BucketName "notes") NoOp
  log $ show $ send $ ConnectToBucket connection (BucketName "tags") NoOp
  log "Done"

