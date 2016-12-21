module Simperium where

import Control.Monad.Aff (Aff, forkAff)
import Control.Monad.Aff.AVar (AVAR, AVar, makeVar, putVar, takeVar)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Console (CONSOLE, logShow)
import Prelude

main :: forall e. Aff (avar :: AVAR, console :: CONSOLE | e) Unit
main = do
    inqueue <- makeVar
    outqueue <- makeVar
    forkAff $ do eventDispatcher inqueue outqueue
    putVar inqueue "Initial event"
    pure unit

eventDispatcher :: forall a e. AVar a -> AVar a -> Aff (avar :: AVAR, console :: CONSOLE | e) Unit
eventDispatcher inqueue outqueue = do
    event <- takeVar inqueue
    liftEff $ logShow "Got an event"
    eventDispatcher inqueue outqueue