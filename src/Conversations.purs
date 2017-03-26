module Conversations where
  
import Prelude

import Control.Monad.Aff
import Control.Monad.Eff.Console (CONSOLE, log)
import WebSocket (WEBSOCKET)

import Simperium.Messages (AppMessage(..), ServerMessage(..))

-- converseServer :: forall e. ServerMessage -> Aff (console :: CONSOLE, ws :: WEBSOCKET | e) (Array AppMessage)

-- converseServer (AuthValid email) = pure []
-- converseServer (AuthInvalid TokenFormatInvalid error) = pure []
-- converseServer (AuthInvalid TokenInvalid err) = pure []
-- converseServer (AuthInvalid UnspecifiedError err) = pure []
-- converseServer (ChangeFailed key DocumentTooLarge changes) = do
--     Entity _ baseVersion json <- getEntity key
--     [SendEntity key baseVersion json]

-- converseServer (ChangeFailed key DupicateChange _) = pure []
-- converseServer (ChangeFailed _ EmptyChange _) = pure []

{-
When receiving a list of failed changes we can at least try to
extract out the changes and send them back one-by-one. Hopefully
a few of them will succeed even though they didn't all succeed.
-}
-- converseServer (ChangeFailed key InternalServerError changes) = do
--     map queueChange changes
--     where
--         queueChange changeId = do
--             change <- getChange changeId
--             Entity _ baseVersion _ <- getEntity key
--             SendChange key baseVersion changeId change

-- converseServer message = pure []
