module SimperiumTypes where

import Prelude
import Data.Generic (class Generic, gEq, gShow)
import Data.Maybe (Maybe)

newtype StreamMessage = StreamMessage String

instance showStreamMessage :: Show StreamMessage where
    show (StreamMessage s) = s

class StreamApi a where
    fromStream :: StreamMessage -> a
    toStream :: a -> StreamMessage

newtype AppId = AppId String
newtype AccessToken = AccessToken String
newtype ApiVersion = ApiVersion String
newtype BucketName = BucketName String
newtype BucketVersion = Version String
newtype ChangeId = ChangeId UUID
newtype Channel = Channel Int
newtype ClientId = ClientId String
newtype EmailAddress = EmailAddress String
newtype EntityVersion = EntityVersion Int
newtype JsonData = JsonData String
newtype JsonDiff = JsonDiff String
newtype Key = Key String
newtype LibraryName = LibraryName String
newtype LibraryVersion = LibraryVersion String
newtype UUID = UUID String

derive instance genericAppId :: Generic AppId
derive instance genericAccessToken :: Generic AccessToken
derive instance genericApiVersion :: Generic ApiVersion
derive instance genericBucketName :: Generic BucketName
derive instance genericBucketVersion :: Generic BucketVersion
derive instance genericChange :: Generic Change
derive instance genericChangeId :: Generic ChangeId
derive instance genericChannel :: Generic Channel
derive instance genericClientId :: Generic ClientId
derive instance genericConnectionInfo :: Generic ConnectionInfo
derive instance genericEmailAddress :: Generic EmailAddress
derive instance genericEntityVersion :: Generic EntityVersion
derive instance genericJsonData :: Generic JsonData
derive instance genericJsonDiff :: Generic JsonDiff
derive instance genericKey :: Generic Key
derive instance genericLibraryName :: Generic LibraryName
derive instance genericLibraryVersion :: Generic LibraryVersion
derive instance genericUUID :: Generic UUID

data StreamAtom
    = ChannelCommand Channel Command
    | ChannelMessage Channel Message
    | ReceiveHeartbeat Int
    | SendHeartbeat Int
    | StartLogging LoggingLevel
    | StopLogging
    | UnknownAtom

instance streamApiStreamAtom :: StreamApi StreamAtom where
    fromStream _ = UnknownAtom

    toStream (ChannelCommand (Channel c) command) = 
        StreamMessage $ (show c) <> ":" <> commandMessage
            where
                commandMessage = case (toStream command) of (StreamMessage s) -> s

    toStream (ChannelMessage (Channel c) message) = 
        StreamMessage $ (show c) <> ":" <> messageMessage
            where
                messageMessage = case (toStream message) of (StreamMessage s) -> s
   
    toStream (ReceiveHeartbeat n) = StreamMessage ""
    toStream (SendHeartbeat n) = StreamMessage $ "h:" <> show n
    toStream (StartLogging Normal) = StreamMessage "log:1"
    toStream (StartLogging Verbose) = StreamMessage "log:2"
    toStream StopLogging = StreamMessage "log:0"
    toStream UnknownAtom = StreamMessage ""

derive instance genericStreamAtom :: Generic StreamAtom

instance showStreamAtom :: Show StreamAtom where
    show = gShow

instance eqStreamAtom :: Eq StreamAtom where
    eq = gEq

data Command
    = ConnectToBucket ConnectionInfo BucketName Command
    | RequestEntity Key EntityVersion
    | RequestChanges BucketVersion
    | RequestIndex BucketVersion Int
    | SendChange Key EntityVersion ChangeId Change
    | SendObject Key JsonData
    | NoOp

instance streamApiCommand :: StreamApi Command where
    fromStream _ = NoOp

    toStream (ConnectToBucket ci (BucketName bucket) cmd) =
        StreamMessage $ "init:{\"name\": " <> show bucket <> "}"

    toStream (RequestEntity (Key k) (EntityVersion v)) =
        StreamMessage $ "e:" <> k <> "." <> show v

    toStream a = StreamMessage $ "NA " <> show a

derive instance genericCommand :: Generic Command

instance showCommand :: Show Command where
    show = gShow

instance eqCommand :: Eq Command where
    eq = gEq

data Message
    = AuthValid EmailAddress
    | AuthInvalid AuthError String
    | ChangeFailed Key ChangeError (Array ChangeId)
    | EntityNotFound Key EntityVersion
    | ReceiveChanges (Array ChangeSet)
    | ReceiveEntity Key EntityVersion JsonData
    | ReceiveIndex BucketVersion (Array KeyVersionPair) (Maybe BucketVersion)
    | VersionNotFound BucketVersion
    | UnknownMessage

derive instance genericMessage :: Generic Message

instance showMessage :: Show Message where
    show = gShow

instance eqMessage :: Eq Message where
    eq = gEq

instance streamApiMessage :: StreamApi Message where
    fromStream _ = UnknownMessage
    toStream a = StreamMessage $ "NA " <> show a

data AuthError
    = TokenFormatInvalid
    | TokenInvalid
    | UnspecifiedError

derive instance genericAuthError :: Generic AuthError

data ChangeError
    = DocumentTooLarge
    | DuplicateChange
    | EmptyChange
    | InternalServerError
    | InvalidDiff
    | InvalidEntity
    | InvalidIdOrSchema
    | InvalidPermissions
    | InvalidVersion

derive instance genericChangeError :: Generic ChangeError

data ChangeSet = ChangeSet ClientId BucketVersion Key EntityVersion EntityVersion Change (Array ChangeId)

derive instance genericChangeSet :: Generic ChangeSet

data Change
    = EntityDiff JsonDiff
    | EntityRemoval

data ConnectionInfo = ConnectionInfo AppId AccessToken ApiVersion ClientId LibraryName LibraryVersion

data Entity = Entity Key EntityVersion JsonData

data KeyVersionPair = KeyVersionPair Key EntityVersion

derive instance genericKeyVersionPair :: Generic KeyVersionPair

data LoggingLevel
    = Normal
    | Verbose

derive instance genericLoggingLevel :: Generic LoggingLevel
