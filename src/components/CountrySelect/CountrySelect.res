open CountryTypes
open CssJs

let countryLabelStyles = style(. [display(#flex), gap(8->#px)])

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

let getCountryByCode = (countries, code) => {
  Belt.Option.flatMap(code, code => {
    countries->Js.Array2.find(thisCountry => thisCountry.value == code)
  })
}

@react.component
let make = (~onChange, ~country, ~className=?) => {
  let countriesState = CountryHook.use()

  let (countryCode, setCountryCode) = React.useState(_ => country)

  let onCountryChange = React.useCallback0(newCountry => {
    setCountryCode(_ => newCountry->Belt.Option.map(country => country.value))
    onChange(newCountry)
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
  | Error => <div> {React.string("Something went wrong :(")} </div>
  }
}
