# Data communication

## Conversations

This Simperium library is essentially an event loop which interprets 
incoming events and then dispatches outgoing events as responses.
Almost every process is asynchronous by design and responses have no 
direct connection to the events which triggered them.
Every operation brings with it the risk of failure, but as with the
responses, they lack a direct coupling to their preceeding events.

Although the events occur asynchronously and are decoupled from one
another, they do form calls and responses in the form of conversations.
**Conversations** define the types of situations that can occur in the
course of Simperium communication and how the library and application
ought to respond to given events based on given existing state.

### Example conversation

The following describes a particular interaction when the server
announces updates to an entity which does not exist in the Local
datastore for this library.
We see the opening event which starts the conversation, an indication
of the local state at the time of arrival, and the new commands which
are queued up to be dispatched back to the Simperium server in reponse.

 1. Message from server announces `ReceiveChanges` with `ModifyEntity`
 2. Local datastore lacks specified entity
 3. `ReceiveChanges` message is ignored; `RequestEntity` shipped to server

Although it would be tempting to continue this conversation though the
message we expect to receive from the server in hypothetical step four
we will restrain ourselves from doing this.
It's important to remember how asynchronously and decoupled the Simperium
model permits us to think; the response from the server actually starts
a new conversation triggered by a `ReceiveEntity` message.
The result of this is that conversations are short and simple to reason
about because the amount of state-tracking has been minimized.

## Events

Events are the atoms of change and data transport.

### Event types summary

| Event type | Source | Target | Meaning | Triggers |
|------------|--------|--------|---------|----------|
| Announcement | library | app | Announces updated data for an entity in use by the host application | |
| Command | library | server | Requests some action or change on the server | Message |
| Message | server | library | Responds to some command or announces remote changes | Announcement \| Command |
| Response | library | app | Responds to some data request made by the app | |
| Request | app | library | Requests indices or entities from Simperium | Command \| Response |
| Update | app | library | Requests changes to entities or buckets in Simperium | Command \| Response |
