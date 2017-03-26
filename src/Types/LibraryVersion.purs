module Types.LibraryVersion
  ( LibraryVersion
  , libraryVersion
  ) where

newtype LibraryVersion = LibraryVersion String

libraryVersion :: String -> LibraryVersion
libraryVersion = LibraryVersion
