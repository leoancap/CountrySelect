@react.component
let make = () => {
  let countriesState = CountryHook.use()

  switch countriesState {
  | Data(countries) =>
    <ReactSelect
      options=countries
      searchable=true
      filterOption={ReactSelect.createFilter({"ignoreAccents": false})}
      formatOptionLabel={thisOption =>
        <div>
          <span className={`fi fi-${thisOption.value}`} />
          <span> {thisOption.label->React.string} </span>
        </div>}
    />
  | Fetching => <div> {React.string("Fetching...")} </div>
  | Error => <div> {React.string("Something went wrong :(")} </div>
  }
}
