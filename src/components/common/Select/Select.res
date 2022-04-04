open CssJs

module Menu = {
  let className = style(. [
    position(#absolute),
    marginTop(8->#px),
    borderRadius(4->#px),
    backgroundColor(#hex("ffffff")),
    zIndex(2),
  ])
  @react.component
  let make = (~children) => {
    <div className> children </div>
  }
}

module Backdrop = {
  let className = style(. [
    top(#zero),
    right(#zero),
    bottom(#zero),
    left(#zero),
    position(#fixed),
    zIndex(1),
  ])
  @react.component
  let make = (~onClick) => {
    <div className onClick />
  }
}

module Dropdown = {
  let className = style(. [position(#relative)])
  @react.component
  let make = (~children, ~isOpen, ~target, ~onClose) => {
    <div className>
      {target}
      {isOpen ? <Menu> children </Menu> : React.null}
      {isOpen ? <Backdrop onClick=onClose /> : React.null}
    </div>
  }
}

module Svg = {
  @react.component
  let make = (~className=?, ~children) => {
    <svg
      ?className width="32" height="32" viewBox="-8 -8 24 24" focusable="false" role="presentation">
      children
    </svg>
  }
}

module DropdownIndicator = {
  let className = style(. [color(#var("tomato")), height(-24->#px), height(-32->#px)])

  @react.component
  let make = () => {
    <div className>
      <Svg>
        <path
          fillRule="evenodd"
          clipRule="evenodd"
          d="M10 5C10 6.01927 9.69501 6.96731 9.17131 7.75783L12.47 11.06L11.06 12.47L7.75786 9.17129C6.96734 9.695 6.01929 10 5 10C2.23858 10 0 7.76142 0 5C0 2.23858 2.23858 0 5 0C7.76142 0 10 2.23858 10 5ZM5 8.2C6.76731 8.2 8.2 6.76731 8.2 5C8.2 3.23269 6.76731 1.8 5 1.8C3.23269 1.8 1.8 3.23269 1.8 5C1.8 6.76731 3.23269 8.2 5 8.2Z"
          fill="#333333"
        />
      </Svg>
    </div>
  }
}

module ChevronDown = {
  let className = CssJs.style(. [marginRight(-6->#px)])

  @react.component
  let make = () => {
    <Svg className>
      <path
        d="M8.292 10.293a1.009 1.009 0 0 0 0 1.419l2.939 2.965c.218.215.5.322.779.322s.556-.107.769-.322l2.93-2.955a1.01 1.01 0 0 0 0-1.419.987.987 0 0 0-1.406 0l-2.298 2.317-2.307-2.327a.99.99 0 0 0-1.406 0z"
        fill="currentColor"
        fillRule="evenodd"
      />
    </Svg>
  }
}
@react.component
let make = (
  ~autoFocus=?,
  ~backspaceRemovesValue=?,
  ~className=?,
  ~controlShouldRenderValue=?,
  ~formatOptionLabel,
  ~hideSelectedOptions=?,
  ~isClearable=?,
  ~onChange=_ => (),
  ~options,
  ~value=None,
) => {
  let (isOpen, setIsOpen) = React.useState(_ => false)
  let (value, setValue) = React.useState(_ => value)
  let toggleOpen = _ => {
    setIsOpen(isOpen => !isOpen)
  }
  let onSelectChange = newValue => {
    toggleOpen()
    let optionValue = Js.Nullable.toOption(newValue)
    setValue(_ => optionValue)
    onChange(optionValue)
  }

  let components = ReactSelect.createComponents(
    ~menuList=({children, focusedOption}) => {
      let rowCount = children->Js.Array2.isArray ? children->Js.Array2.length : 0
      let focusedOptionIndex =
        children->Js.Array2.isArray
          ? children->Js.Array2.findIndex(thisChild => {
              let thisOption = ReactSelect.convertChildToOption(thisChild)
              thisOption.props.data == focusedOption
            })
          : 0
      <ReactVirtualized.AutoSizer disableHeight=true>
        {({width}) =>
          <ReactVirtualized.List
            height={200}
            width
            rowCount
            rowHeight={_ => 35}
            scrollToIndex={focusedOptionIndex > 0 ? focusedOptionIndex : 0}
            rowRenderer={({index, style}) => {
              <div key={index->Js.Int.toString} style={style}>
                {if children->Js.Array2.isArray {
                  children[index]
                } else {
                  children->React.array
                }}
              </div>
            }}
          />}
      </ReactVirtualized.AutoSizer>
    },
    ~dropdownIndicator=() => <DropdownIndicator />,
    ~indicatorSeparator=() => React.null,
    ~clearIndicator=() => React.null,
    (),
  )

  <div>
    <Dropdown
      isOpen
      onClose={toggleOpen}
      target={<button onClick={toggleOpen}> {formatOptionLabel(value)} </button>}>
      <ReactSelect
        ?autoFocus
        ?backspaceRemovesValue
        ?className
        ?controlShouldRenderValue
        ?hideSelectedOptions
        ?isClearable
        components
        formatOptionLabel
        menuIsOpen={true}
        onChange={onSelectChange}
        options
        placeholder={"Search"->React.string}
        styles={ReactSelect.createSelectStyles(
          (),
          ~menu={() => ReactDOMStyle.make(~boxShadow="inset 0 1px 0 rgba(0, 0, 0, 0.1)", ())},
          ~control={
            provided => {
              open ReactDOMStyle
              combine(
                provided,
                make(
                  ~width="230px",
                  ~height="35px",
                  ~flexDirection="row-reverse",
                  ~marginBottom="8px",
                  (),
                ),
              )
            }
          },
        )}
        value
      />
    </Dropdown>
  </div>
}
