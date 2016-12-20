module Main where

import Control.Monad.Aff (Aff, forkAff, later', launchAff)
import Control.Monad.Aff.AVar (AVAR, AVar, makeVar, putVar, takeVar)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Console (CONSOLE, logShow)
import Control.Monad.Eff.Exception (EXCEPTION)
import Prelude

import Simperium as Simperium

main :: forall e. Eff (avar :: AVAR, console :: CONSOLE, err :: EXCEPTION | e) Unit
main = void $ launchAff do
    sentinel <- makeVar
    forkAff $ do Simperium.main
    forkAff $ do reportTicks sentinel
    keepAlive sentinel 0

reportTicks :: forall e. AVar Int -> Aff (avar :: AVAR, console :: CONSOLE | e) Unit
reportTicks counter = do
    tick <- takeVar counter
    liftEff $ logShow tick
    reportTicks counter

keepAlive :: forall e. AVar Int -> Int -> Aff (avar :: AVAR | e) Unit
keepAlive sentinel tick = do
    later' 1000 do
        putVar sentinel nextTick
        if keepGoing then keepAlive sentinel nextTick else pure unit
            where
                nextTick = tick + 1
                keepGoing = nextTick < 10