let app = ReactDOM.querySelector("#app")

type root

@module("react-dom/client")
external createRoot: Dom.element => root = "createRoot"

@send external render: (root, React.element) => unit = "render"

switch app {
| Some(element) => createRoot(element)->render(<div> {React.string("Country Select")} </div>)
| None => Js.Exn.raiseError("No id #app found")
}
