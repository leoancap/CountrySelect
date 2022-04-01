let url = "https://gist.githubusercontent.com/rusty-key/659db3f4566df459bd59c8a53dc9f71f/raw/4127f9550ef063121c564025f6d27dceeb279623/counties.json"

let countryListCodec = Jzon.array(CountryTypes.codec)

type state =
  | Data(array<CountryTypes.t>)
  | Fetching
  | Error

let use = () => {
  let (countries, setCountries) = React.useState(_ => Fetching)

  React.useEffect0(() => {
    open Promise

    Fetch.get(url)
    ->thenResolve(json =>
      switch json->Jzon.decodeWith(countryListCodec) {
      | Ok(countries) => setCountries(_ => Data(countries))
      | Error(_) => setCountries(_ => Error)
      }
    )
    ->ignore

    None
  })

  countries
}
