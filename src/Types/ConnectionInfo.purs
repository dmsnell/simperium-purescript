module Types.ConnectionInfo
  ( ConnectionInfo
  ) where

import Types.AppId (AppId)
import Types.AccessToken (AccessToken)
import Types.ApiVersion (ApiVersion)
import Types.ClientId (ClientId)
import Types.LibraryName (LibraryName)
import Types.LibraryVersion (LibraryVersion)

data ConnectionInfo =
  ConnectionInfo
    AppId
    AccessToken
    ApiVersion
    ClientId
    LibraryName
    LibraryVersion
