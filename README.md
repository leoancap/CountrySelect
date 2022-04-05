# CountrySelect

## Try it out

https://countries-select.netlify.app/

## Setup

Install dependencies:

```sh
 yarn
```

## Up & Running

1. Compile rescript 

```sh
  yarn res:watch
```

2. Execute the dev server:

```sh
 yarn dev
```

## Scripts

| Script       | Description                                                   |
| ------------ | ------------------------------------------------------------- |
| `res:watch`  | Cleans workspace and executes the rescript compiler           |
| `res:build`  | Build the rescript files                                      |
| `dev`        | Run dev server                                                |
| `build`      | Build the Javascript files                                    |

## Folder Structure

```
├── src
   |─── bindings
   |─── components
   |─── hooks
   |──- types
```

| Folder           | Description                                                                                                                      |
| ---------------- | -----------------------------------------------------------------------------|
| `src/components` | Folder with all the components, domain specific ones as well as shared ones  |
| `src/bindings/`  | Folder containing bindings that interop with existing Javascript Libraries   |
| `src/hooks/`     | Folder containing the custom hooks to be used accross the application        |
| `src/types/`     | The Domain types definition                                                  |
