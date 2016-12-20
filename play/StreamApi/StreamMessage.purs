module StreamApi.StreamMessage where

import Prelude
import Data.Monoid (class Monoid)

newtype StreamMessage = StreamMessage String

instance semigroupStreamMessage :: Semigroup StreamMessage where
    append (StreamMessage a) (StreamMessage b) = StreamMessage $ a <> b

instance monoidStreamMessage :: Monoid StreamMessage where
    mempty = StreamMessage ""

instance showStreamMessage :: Show StreamMessage where
    show (StreamMessage s) = s
