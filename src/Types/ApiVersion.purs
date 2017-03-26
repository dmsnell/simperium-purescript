module Types.ApiVersion
    ( ApiVersion
    , apiVersion
    ) where

import Prelude (class Eq, class Ord, compare, (==))

newtype ApiVersion = ApiVersion String

apiVersion :: ApiVersion
apiVersion = ApiVersion "1.1"

instance apiVersionEq :: Eq ApiVersion where
    eq (ApiVersion a) (ApiVersion b) = a == b

instance apiVersionOrd :: Ord ApiVersion where
    compare (ApiVersion a) (ApiVersion b) = compare a b
