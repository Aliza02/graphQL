# GraphQL

GraphQL is a query language for APIs, designed to give clients exactly the data they
need-nothing more, nothing less. Unlike REST APIs, which require multiple
endpoints, GraphQL allows us to fetch all the necessary data in a single query with a
single endpoint.
GraphQL provides more control over data handling, allowing users to fetch only required data, and avoiding extra resources.
## Problem it solves:
GraphQL fixes the problem of under-fetching and over-fetching, reducing network
overhead.<br>
<b>*under-fetching:</b> when an endpoint call does not return sufficient data required at that
point of request, that event is referred to as under-fetching.
<b>*over-fetching:</b> when an endpoint call returns all the data associated with an endpoint
instead of particular fields required at that point of request, it is referred to as over-
fetching.

#### It's better to use GraphQL for APIs for the following reasons:
1. It allows fetching necessary data with a single endpoint in a single query, reducing
network overhead and unnecessary API calls.
2. Fetching required data only makes responses smaller and faster.
3. It has a built-in state management mechanism.
4. Requires no versioning of endpoints.
#### GraphQL provides three main operations to interact with the data.
1.<b> Querying:</b> Request for fetching data.<br>
2. <b>Mutation:</b> operation to modify the data. It includes addition, updation, and
deletion.<br>
3. <b>subscription:</b> Establish a continuous connection between client and server to fetch
new data as soon as it becomes available.

#### Main Components of GraphQL:
1. <b>GraphQL Client:</b> it establishes a connection between the application and the graphQL server.<br>
2. <b>ValueNotifier:</b> It listens to the changes that occur in the state and notifier listeners<br>
3. <b>GraphQl Provider:</b> It is a widget that provides access to GraphQL clients and ensures
its availability throughout the widget tree.


<b><I> To get a practical understanding, go through the code and tweak to study changes.
