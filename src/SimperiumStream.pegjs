SimperiumStream
  = ss:(s:SimperiumMessage [\n] { return s })* s:SimperiumMessage [\n]*
  { return [].concat( ss ).concat( s ) }
  
SimperiumMessage
  = AuthValid
  / ConnectToBucket
  / RequestChanges

AuthValid
  = channel:ChannelId ":auth:" emailAddress:EmailAddress
  { return { type: "AuthValid", channel, emailAddress } }

ConnectToBucket
  = channel:ChannelId ":init:" data:JsonData
  { return { type: "ConnectToBucket", channel,
    bucketName: data.name,
    clientId: data.clientid,
    apiVersion: data.api,
    accessToken: data.token,
    appId: data[ "app_id" ],
    libraryName: data.library,
    libraryVersion: data.version,
  } }

RequestChanges
  = channel:ChannelId ":cv:" changeVersion:ChangeVersion
  { return { type: "RequestChanges", channel, changeVersion } }

ChangeVersion
  = v:[a-f0-9]+
  { return v.join("") }
  
ChannelId
  = c:[0-9]+ 
  { return parseInt( c.join(""), 10 ) }
  
EmailAddress
  = mailbox:[a-z0-9\._+-]+ "@" host:[a-z0-9\._+-]+
  { return mailbox.join("") + "@" + host.join("") }

JsonData
  = d:[^\n]+
  { return JSON.parse( d.join("") ) }