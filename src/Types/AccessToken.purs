module Types.AccessToken
  ( AccessToken
  , accessToken
  ) where

import Prelude (class Show, show)

newtype AccessToken = AccessToken String

accessToken :: String -> AccessToken
accessToken = AccessToken

instance showAccessToken :: Show AccessToken where
  show (AccessToken s) = show s
