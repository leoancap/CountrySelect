@react.component
let make = () => {
  let countriesState = CountryHook.use()

  switch countriesState {
  | Data(countries) =>
    <ReactSelect
      options=countries
      searchable=true
      formatOptionLabel={thisOption => <div> {thisOption.label->React.string} </div>}
    />
  | Fetching => <div> {React.string("Fetching...")} </div>
  | Error => <div> {React.string("Something went wrong :(")} </div>
  }
}
