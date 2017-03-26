module Types.ClientId
    ( ClientId
    , clientId
    ) where

import Prelude (class Show, show)

newtype ClientId = ClientId String

clientId :: ClientId
clientId = ClientId "simperium-purescript-0.1.0"

instance showClientId :: Show ClientId where
  show (ClientId s) = show s
