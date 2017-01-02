## Connecting to a bucket

### Successful login
| Sender | Target | Message | State | Notes |
|---|---|---|---|---|---|
| library | server | ConnectToBucket | |
| | | | valid credentials |
| server | library | AuthValid email | |

### Invalid login: bad credentials
| Sender | Target | Message | State | Notes |
|---|---|---|---|---|---|
| library | server | ConnectToBucket | |
| | | |  invalid credentials |
| server | library | AuthInvalid InvalidToken | |

### Invalid login: token format invalid
| Sender | Target | Message | State | Notes |
|---|---|---|---|---|---|
| library | server | ConnectToBucket | |
| | | |  wrong type of token |
| server | library | AuthInvalid TokenFormatInvalid | |

## Changes

### Change failed: document too large
| Sender | Target | Message | State | Notes |
|---|---|---|---|---|---|
| server | library | ChangeFailed changes | | |
| | | | changes were diffs | |
| library | server | SendEntity | | maybe the diff blew up in size but the actual data is small enough |

### Change failed: duplicate changes
| Sender | Target | Message | State | Notes |
|---|---|---|---|---|---
| server | library | ChangeFailed | | |
