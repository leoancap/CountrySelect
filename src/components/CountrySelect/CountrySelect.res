open CountryTypes
open CssJs

let countryLabelStyles = style(. [display(#flex), gap(Theme.Spacing.sm->#px)])

let renderCountryLabel = optionCountry => {
  <div className=countryLabelStyles>
    {switch optionCountry {
    | Some(country) => <>
        <span className={`fi fi-${country.value}`} /> <span> {country.label->React.string} </span>
      </>
    | None => "Select a Country"->React.string
    }}
  </div>
}

let getCountryByCode = (countries, code) =>
  Belt.Option.flatMap(code, _code => countries->Js.Array2.find(_country => _country.value == _code))

@react.component
let make = (~onChange, ~country, ~className=?) => {
  let countriesState = CountryHook.use()

  let (countryCode, setCountryCode) = React.useState(_ => country)

  let onCountryChange = React.useCallback0(_country => {
    setCountryCode(_ => _country->Belt.Option.map(country => country.value))
    onChange(_country)
  })

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
      onChange={onCountryChange}
      value={countries->getCountryByCode(countryCode)}
      options={countries}
    />
  | Fetching => <div> {React.string("Fetching...")} </div>
  | NonIdealState(error) =>
    switch error {
    | ServerError => <div> {React.string("Server Error ")} </div>
    | DecodeError => <div> {React.string("Data has been corrupted")} </div>
    }
  }
}
