module Simperium where

import Control.Monad.Aff (Aff, forkAff)
import Control.Monad.Aff.AVar (AVAR, AVar, makeVar, takeVar)
import Control.Monad.Eff.Console (CONSOLE)
import Control.Monad.Rec.Class (forever)
import Prelude

main :: forall e. Aff (avar :: AVAR, console :: CONSOLE | e) Unit
main = do
    -- Communication queues
    fromApp <- makeVar
    toApp <- makeVar
    fromServer <- makeVar
    toServer <- makeVar

    -- Connect communication pieces
    forkAff $ do connectWebSocket fromServer toServer
    forkAff $ do connectWebWorker fromApp toApp

    -- Connect event processing pieces
    forkAff $ do processMessages fromServer toServer toApp
    forkAff $ do processRequests toServer fromApp toApp
    forkAff $ do processUpdates toServer fromApp toApp

    pure unit

connectWebSocket :: forall a e. AVar a -> AVar a -> Aff (avar :: AVAR | e) Unit
connectWebSocket fromServer toServer = forever $ do
    {-
    ws = new websocket
    ws.on = (\message -> putVar fromServer message)
    -}
    command <- takeVar toServer
    {-
    ws.send command
    -}
    pure unit

connectWebWorker :: forall a e. AVar a -> AVar a -> Aff (avar :: AVAR | e) Unit
connectWebWorker fromApp toApp = forever $ do
    {-
    worker = new worker( parent )
    worker.on = (\message -> putVar fromApp message)
    -}
    event <- takeVar toApp
    {-
    worker.send event
    -}
    pure unit

processMessages :: forall a e. AVar a -> AVar a -> AVar a -> Aff (avar :: AVAR | e) Unit
processMessages fromServer toServer toApp = do
    message <- takeVar fromServer
    {-
    ( announcements, commands ) <- processMessage message
    dispatchAnnouncements toApp announcements
    dispatchCommands toServer commands
    -}
    processMessages fromServer toServer toApp

processRequests :: forall a e. AVar a -> AVar a -> AVar a -> Aff (avar :: AVAR | e) Unit
processRequests toServer fromApp toApp = do
    request <- takeVar fromApp
    {-
    ( commands, responses ) <- processRequest request
    dispatchCommands toServer commands
    dispatchResponses toApp responses
    -}
    processRequests toServer fromApp toApp

processUpdates :: forall a e. AVar a -> AVar a -> AVar a -> Aff (avar :: AVAR | e) Unit
processUpdates toServer fromApp toApp = do
    update <- takeVar fromApp
    {-
    ( commands, responses ) <- processUpdate update
    dispatchCommands toServer commands
    dispatchResponses toApp responses
    -}
    processUpdates toServer fromApp toApp