type reactRoot
@module("react-dom/client") external createRoot: Dom.element => reactRoot = "createRoot"
@send external render: (reactRoot, React.element) => unit = "render"

module Main = {
  @react.component
  let make = () => {
    <CountrySelect value=None onChange={newValue => Js.log({newValue})} />
  }
}

let rootElement = ReactDOM.querySelector("#app")

switch rootElement {
| Some(element) => createRoot(element)->render(<Main />)
| None => Js.Exn.raiseError("No id #app found")
}
