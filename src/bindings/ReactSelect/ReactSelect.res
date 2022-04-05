type menuListProps<'a> = {
  children: array<React.element>,
  focusedOption: 'a,
  options: array<'a>,
  maxHeight: int,
  getValue: unit => 'a,
}

type components<'a> = {
  "MenuList": option<menuListProps<'a> => React.element>,
  "DropdownIndicator": option<unit => React.element>,
  "IndicatorSeparator": option<unit => React.element>,
  "ClearIndicator": option<unit => React.element>,
}

let createComponents = (
  ~menuList=?,
  ~clearIndicator=?,
  ~dropdownIndicator=?,
  ~indicatorSeparator=?,
  (),
): components<'a> => {
  {
    "MenuList": menuList,
    "DropdownIndicator": dropdownIndicator,
    "IndicatorSeparator": indicatorSeparator,
    "ClearIndicator": clearIndicator,
  }
}
type selectStyles = {"control": ReactDOMStyle.t => ReactDOMStyle.t, "menu": unit => ReactDOMStyle.t}

@obj
external createSelectStyles: (
  ~control: ReactDOMStyle.t => ReactDOMStyle.t=?,
  ~menu: unit => ReactDOMStyle.t=?,
  unit,
) => selectStyles = ""

type innerProps<'a> = {data: 'a}
type innerElement<'a> = {props: innerProps<'a>}
external convertChildToOption: React.element => innerElement<'a> = "%identity"

@module("react-select") @react.component
external make: (
  ~autoFocus: bool=?,
  ~backspaceRemovesValue: bool=?,
  ~captureMenuScroll: bool=?,
  ~className: string=?,
  ~components: components<'a>=?,
  ~controlShouldRenderValue: bool=?,
  ~formatOptionLabel: option<'a> => React.element=?,
  ~hideSelectedOptions: bool=?,
  ~isClearable: bool=?,
  ~escapeClearsValue: bool=?,
  ~menuIsOpen: bool=?,
  ~onMenuClose: unit => unit=?,
  ~onChange: Js.Nullable.t<'a> => unit=?,
  ~options: array<'a>,
  ~placeholder: React.element=?,
  ~searchable: bool=?,
  ~styles: selectStyles=?,
  ~value: option<'a>=?,
) => React.element = "default"
