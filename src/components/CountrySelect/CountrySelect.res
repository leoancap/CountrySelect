open CountryTypes

let renderCountryLabel = optionCountry => {
  switch optionCountry {
  | Some(country) =>
    <div>
      <span className={`fi fi-${country.value}`} /> <span> {country.label->React.string} </span>
    </div>
  | None => "Select a Country"->React.string
  }
}

@react.component
let make = (~onChange, ~value, ~className=?) => {
  let countriesState = CountryHook.use()

  switch countriesState {
  | Data(countries) =>
    <Select
      ?className
      autoFocus={true}
      backspaceRemovesValue={true}
      controlShouldRenderValue={false}
      formatOptionLabel={renderCountryLabel}
      hideSelectedOptions={false}
      isClearable={true}
      onChange
      options={countries}
      value
    />
  | Fetching => <div> {React.string("Fetching...")} </div>
  | Error => <div> {React.string("Something went wrong :(")} </div>
  }
}
