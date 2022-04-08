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
      {target} {isOpen ? <> <Menu> children </Menu> <Backdrop onClick=onClose /> </> : React.null}
    </div>
  }
}

module DropdownIndicator = {
  let className = style(. [height(-24->#px), height(-32->#px)])

  @react.component
  let make = () => {
    <div className>
      <svg width="32" height="32" viewBox="-8 -8 24 24" focusable="false" role="presentation">
        <path
          fillRule="evenodd"
          clipRule="evenodd"
          d="M10 5C10 6.01927 9.69501 6.96731 9.17131 7.75783L12.47 11.06L11.06 12.47L7.75786 9.17129C6.96734 9.695 6.01929 10 5 10C2.23858 10 0 7.76142 0 5C0 2.23858 2.23858 0 5 0C7.76142 0 10 2.23858 10 5ZM5 8.2C6.76731 8.2 8.2 6.76731 8.2 5C8.2 3.23269 6.76731 1.8 5 1.8C3.23269 1.8 1.8 3.23269 1.8 5C1.8 6.76731 3.23269 8.2 5 8.2Z"
          fill="#333333"
        />
      </svg>
    </div>
  }
}

module ChevronDown = {
  let className = CssJs.style(. [display(#flex), height(28->#px)])

  @react.component
  let make = () => {
    <svg width="8" height="8" viewBox="0 0 8 5" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path fillRule="evenodd" clipRule="evenodd" d="M0 0H8L4 5L0 0Z" fill="#333333" />
    </svg>
  }
}

module NoOptions = {
  let className = CssJs.style(. [
    display(#flex),
    justifyContent(#center),
    alignItems(#center),
    height(35->#px),
  ])

  @react.component
  let make = () => {
    <div className> <span> {"No Options"->React.string} </span> </div>
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
  ~onChange,
  ~options,
  ~value,
) => {
  let (isOpen, setIsOpen) = React.useState(_ => false)
  let toggleOpen = _ => {
    setIsOpen(isOpen => !isOpen)
  }
  let onSelectChange = newValue => {
    newValue->Js.Nullable.toOption->onChange
  }

  let components = React.useMemo0(() =>
    ReactSelect.createComponents(
      ~menuList=({children, focusedOption}) => {
        switch children->ReactSelect.ChildrenOptions.checkHasOptions {
        | None => <NoOptions />
        | Some(options) => {
            let focusedOptionIndex = options->Js.Array2.findIndex(thisChild => {
              let thisOption = ReactSelect.convertChildToOption(thisChild)
              thisOption.props.data == focusedOption
            })

            <ReactVirtualized.AutoSizer disableHeight=true>
              {({width}) =>
                <ReactVirtualized.List
                  height={200}
                  width
                  rowCount={options->Js.Array2.length}
                  rowHeight={_ => 35}
                  scrollToIndex={focusedOptionIndex > 0 ? focusedOptionIndex : 0}
                  rowRenderer={({index, style}) => {
                    <div key={index->Js.Int.toString} style={style}> {options[index]} </div>
                  }}
                />}
            </ReactVirtualized.AutoSizer>
          }
        }
      },
      ~dropdownIndicator=() => <DropdownIndicator />,
      ~indicatorSeparator=() => React.null,
      ~clearIndicator=() => React.null,
      ~noOptionsMessage={
        pr => {
          Js.log2("asdf", {pr})
          "-------------No option"->React.string
        }
      },
      (),
    )
  )

  <div>
    <Dropdown
      isOpen
      onClose={toggleOpen}
      target={<Button
        onKeyDown={e =>
          switch e->ReactEvent.Keyboard.key {
          | "Backspace"
          | "Escape" =>
            onSelectChange(Js.Nullable.null)
          | _ => ()
          }}
        itemRight={<ChevronDown />}
        onClick={toggleOpen}>
        {formatOptionLabel(value)}
      </Button>}>
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
        onChange={newValue => {
          toggleOpen()
          onSelectChange(newValue)
        }}
        options
        placeholder={"Search"->React.string}
        styles={ReactSelect.createSelectStyles(
          (),
          ~menu={() => ReactDOMStyle.make(~boxShadow="inset 0 1px 0 rgba(0, 0, 0, 0.1)", ())},
          ~control=provided => {
            open ReactDOMStyle
            combine(
              provided,
              make(
                ~width="370px",
                ~height="35px",
                ~flexDirection="row-reverse",
                ~marginBottom="8px",
                (),
              ),
            )
          },
        )}
        ?value
      />
    </Dropdown>
  </div>
}
