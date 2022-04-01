@module("react-select") @react.component
external make: (
  ~className: string=?,
  ~options: array<'a>,
  ~onChange: 'a => unit=?,
  ~searchable: bool=?,
  ~formatOptionLabel: 'a => React.element=?,
) => React.element = "default"
