type reactRoot
@module("react-dom/client") external createRoot: Dom.element => reactRoot = "createRoot"
@send external render: (reactRoot, React.element) => unit = "render"

let rootElement = ReactDOM.querySelector("#app")

switch rootElement {
| Some(element) =>
  createRoot(element)->render(
    <CountrySelect
      className="custom-class" country=Some("us") onChange={newCountry => Js.log({newCountry})}
    />,
  )
| None => Js.Exn.raiseError("No id #app found")
}
