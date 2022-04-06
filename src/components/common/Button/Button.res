open Belt

module Styles = {
  open CssJs
  let container = style(. [
    display(#flex),
    gap(8->#px),
    justifyContent(#spaceBetween),
    alignItems(#center),
    border(1->#px, #solid, rgba(0, 0, 0, 20.->#percent)),
    borderRadius(3->#px),
    height(26->#px),
    background("fff"->#hex),
  ])
}

@react.component
let make = (~onClick=?, ~onKeyDown=?, ~itemRight=?, ~children) => {
  <button ?onKeyDown className=Styles.container ?onClick>
    {children}
    {Option.mapWithDefault(itemRight, React.null, el => {
      <div> {el} </div>
    })}
  </button>
}
