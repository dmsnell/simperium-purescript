module Simperium where

import Control.Monad.Aff (Aff)
import Control.Monad.Aff.AVar (AVAR, AVar, makeVar, takeVar)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Console (CONSOLE, logShow)
import Prelude

main :: forall e. Aff (avar :: AVAR, console :: CONSOLE | e) Unit
main = do
    inqueue <- makeVar
    outqueue <- makeVar
    eventDispatcher inqueue outqueue
    pure unit

eventDispatcher :: forall a e. AVar a -> AVar a -> Aff (avar :: AVAR, console :: CONSOLE | e) Unit
eventDispatcher inqueue outqueue = do
    event <- takeVar inqueue
    liftEff $ logShow "Got an event"
    eventDispatcher inqueue outqueue