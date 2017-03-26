module Types.LibraryName
  ( LibraryName
  , libraryName
  ) where

import Prelude (class Show, show)

newtype LibraryName = LibraryName String

libraryName :: String -> LibraryName
libraryName = LibraryName

instance showLibraryName :: Show LibraryName where
  show (LibraryName s) = show s
