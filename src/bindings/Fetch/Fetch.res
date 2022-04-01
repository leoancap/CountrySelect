type response

@send
external json: response => Js.Promise.t<Js.Json.t> = "json"

@val
external fetch: (string, {..}) => Js.Promise.t<response> = "fetch"

let get = url => {
  open Promise

  fetch(
    url,
    {
      "method": "GET",
    },
  )->then(json)
}
