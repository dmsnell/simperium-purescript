module Types.ApiVersion
    ( ApiVersion
    , apiVersion
    ) where

import Prelude (class Eq, class Ord, class Show, compare, show, (==))

newtype ApiVersion = ApiVersion String

apiVersion :: ApiVersion
apiVersion = ApiVersion "1.1"

instance eqApiVersion :: Eq ApiVersion where
    eq (ApiVersion a) (ApiVersion b) = a == b

instance ordApiVersion :: Ord ApiVersion where
    compare (ApiVersion a) (ApiVersion b) = compare a b

instance showApiVersion :: Show ApiVersion where
  show (ApiVersion s) = show s
