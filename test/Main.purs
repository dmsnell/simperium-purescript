module Test.Main where

import Prelude

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE)
import Node.Process (PROCESS)

import Test.Spec.Runner (run)
import Test.Spec.Reporter.Console (consoleReporter)

import StreamApi.Tests (testStreamApi)

main :: forall eff. Eff (console :: CONSOLE, process :: PROCESS | eff) Unit
main = run [consoleReporter] do
  testStreamApi