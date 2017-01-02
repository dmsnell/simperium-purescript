module Conversations where
  
import Prelude

import Control.Monad.Eff.Console (CONSOLE, log)
import WebSocket (WEBSOCKET)

import Simperium.Messages (AppMessage(..), ServerMessage(..))

converseServer :: forall e. ServerMessage -> Aff (console :: CONSOLE, ws :: WEBSOCKET | e) (Array AppMessage)

converseServer
    (AuthValid email)
        = do
            log "Validated " <> email
            []

converseServer
    (AuthInvalid TokenFormatInvalid error)
        = do
            log "Invalid token type; wrong app? " <> error
            []

convserseServer
    (AuthInvalid TokenInvalid err)
        = do
            log "Invalid token: " <> error
            []

converseServer
    (AuthInvalid UnspecifiedError err)
        = do
            log "Unknown error: " <> error
            []

converseServer
    (ChangeFailed key DocumentTooLarge _)
        = do
            log "Entity " <> show key <> " too big, cannot save"
            Entity _ baseVersion json <- getEntity key
            [SendEntity key baseVersion json]

converseServer
    (ChangeFailed key DupicateChange _)
        = do
            log "Detected duplicate changes: dropping"
            []

converseServer
    (ChangeFailed _ EmptyChange _)
        = do
            log "Detected empty change request: dropping"
            []

converseServer
    (ChangeFailed key InternalServerError changes)
        = do
            log "Unexpected server error: retrying"
            map queueChange changes
            where
                queueChange changeId = do
                    change <- getChange changeId
                    Entity _ baseVersion _ <- getEntity key
                    SendChange key baseVersion changeId change

converseServer message = pure []