open Select_Components

type selectActions<'a> = Toggle_Select | Change_Value('a) | Erase_Value

type selectState = Open | Closed

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
  let (selectState, setSelectState) = React.useState(_ => Closed)

  let rec onSelectAction = actionType =>
    switch actionType {
    | Toggle_Select => setSelectState(st => st == Open ? Closed : Open)
    | Change_Value(newValue) => {
        onSelectAction(Toggle_Select)
        newValue->Js.Nullable.toOption->onChange
      }
    | Erase_Value => None->onChange
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
                  rowHeight={_ => Theme.Spacing.sm_4}
                  scrollToIndex={focusedOptionIndex > 0 ? focusedOptionIndex : 0}
                  rowRenderer={({index, style}) =>
                    <div key={index->Js.Int.toString} style={style}> {options[index]} </div>}
                />}
            </ReactVirtualized.AutoSizer>
          }
        }
      },
      ~dropdownIndicator=_ => <DropdownIndicator />,
      ~indicatorSeparator=_ => React.null,
      ~clearIndicator=_ => React.null,
      ~noOptionsMessage=_ => React.null,
      (),
    )
  )

  <div>
    <Dropdown
      isOpen={selectState == Open}
      onClose={_ => onSelectAction(Toggle_Select)}
      target={<Button
        onKeyDown={e => {
          switch e->ReactEvent.Keyboard.key {
          | "Backspace"
          | "Escape" =>
            onSelectAction(Erase_Value)
          | _ => ()
          }
        }}
        itemRight={<ChevronDown />}
        onClick={_ => onSelectAction(Toggle_Select)}>
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
        menuIsOpen={selectState == Open}
        onChange={newValue => Change_Value(newValue)->onSelectAction}
        options
        placeholder={"Search"->React.string}
        styles={ReactSelect.createSelectStyles(
          (),
          ~menu={() => ReactDOMStyle.make(~boxShadow="inset 0 1px 0 rgba(0, 0, 0, 0.1)", ())},
          ~control=provided => {
            open ReactDOMStyle
            open Theme
            combine(
              provided,
              make(
                ~width="370px",
                ~height={`${Spacing.sm_4->Belt.Int.toString}px`},
                ~flexDirection="row-reverse",
                ~marginBottom={`${Spacing.sm_s}px`},
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
