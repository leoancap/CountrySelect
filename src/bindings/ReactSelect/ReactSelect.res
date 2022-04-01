type filterOptions
@module("react-select") external createFilter: {..} => filterOptions = "createFilter"

@module("react-select") @react.component
external make: (
  ~className: string=?,
  ~filterOption: filterOptions=?,
  ~onChange: 'a => unit=?,
  ~options: array<'a>,
  ~formatOptionLabel: 'a => React.element=?,
  ~searchable: bool=?,
) => React.element = "default"
