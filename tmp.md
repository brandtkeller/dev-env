# Validation Types and Identifiers

In OSCAL - `links` contains the following fields:
```yaml
links:
  - href: https://www.example.com/
    rel: nofollow
    text: Example
    media-type: text/html
    resource-fragment: some-fragment
```

One of the concepts that we are exploring is the separation of OSCAL workflows from the "Validations" which include some context around domain and providers for automating the evaluation of a control. 

## Goals
- Simplify the user experience
- Create a standard but extensible workflow for OSCAL -> Validation mapping. 
- Ensure the workflow works for external/remote validations.


## Idea #1 - Rel
Simplify the user experience. Make the declaration of a link to a Lula Validation as simple as possible. The defualt workflow is to use the rel attribute to indicate that Lula has work to perform. 

In the istance of a standard validation - A link to a Lula Validation might look like this:
```yaml
links:
  - href: '#a7377430-2328-4dc4-a9e2-b3f31dc1dff9'
    rel: lula
```

OSCAL states:
> The value may be locally defined

Which means that lula may be able to further utilize the rel attribute.

## Idea #2 - Lula healthcheck
The Validation for a healthcheck is still a standard validation - how we interpret the results for building the assessment-results changes. 

In the event we want to establish a healthcheck - A link to a Lula Validation might look like this:
```yaml
links:
  - href: '#a7377430-2328-4dc4-a9e2-b3f31dc1dff9'
    rel: lula.healthcheck_true
```

## Idea #3 - Lula Override
Important to define the scenario where this applies. This is in a given scenario where we have processed the validations into memory and want to override one validation with another.

In the event we want to override another validation - A link to a Lula Validation might look like this:
```yaml
links:
  - href: '#a7377430-2328-4dc4-a9e2-b3f31dc1dff9'
    rel: lula.override_c7aa02b9-0b4d-47ac-ac01-5fba589443a9
```


## Other Thoughts

### Core Problems to Solve

- We need identifiers currently in both the links AND the back-matter resources.
- It would be great to remove the identifier from the back-matter resources.

- How do we collect and process embedded and external validations?
  - It is possible we could process the embedded validations into memory ONLY when the link with a lula identifier is processed.
  - but this does not work for external validations. It would be inefficient to read the external validations into memory for only a single use.
    - Maybe we store these in a cache?
    - Essentially we process links in series -> embedded validations are retrieved from the back-matter resources.
      - External validations are retrieved from an external file - but we would cache the []validations.
      - Requires a file identifier? or if we have the UUID then that would be good enough?


Need to map this out -> 