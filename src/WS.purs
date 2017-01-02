module WS where

import Prelude

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Exception (EXCEPTION)
import Control.Monad.Eff.Var (($=))
import WebSocket (WEBSOCKET, Connection(..), Message(..), URL(..), newWebSocket)

main :: Eff (err :: EXCEPTION, ws :: WEBSOCKET) Unit
main = do
    Connection socket <- newWebSocket (URL "wss://api.simperium.com/sock/1/accomplishments-drains-540/websocket") []

    socket.onopen $= \event -> do
        socket.send (Message "echo")