type reactRoot
@module("react-dom/client") external createRoot: Dom.element => reactRoot = "createRoot"
@send external render: (reactRoot, React.element) => unit = "render"

module Main = {
  @react.component
  let make = () => {
    let countriesState = CountryHook.use()

    switch countriesState {
    | Data(countries) =>
      <ul>
        {countries
        ->Js.Array2.map(thisCountry =>
          <li key=thisCountry.value> {thisCountry.label->React.string} </li>
        )
        ->React.array}
      </ul>
    | Fetching => <div> {React.string("Fetching...")} </div>
    | Error => <div> {React.string("Something went wrong :(")} </div>
    }
  }
}

let rootElement = ReactDOM.querySelector("#app")

switch rootElement {
| Some(element) => createRoot(element)->render(<Main />)
| None => Js.Exn.raiseError("No id #app found")
}
