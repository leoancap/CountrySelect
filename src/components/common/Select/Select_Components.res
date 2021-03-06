open CssJs
open Theme

module Menu = {
  let className = style(. [
    position(#absolute),
    marginTop(Spacing.sm->#px),
    borderRadius(Radius.sm->#px),
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
  let className = style(. [height(-Spacing.sm_4->#px), height(-Spacing.sm_4->#px)])

  @react.component
  let make = () => {
    <div className>
      <svg
        width={Spacing.sm_4->Belt.Int.toString}
        height={Spacing.sm_4->Belt.Int.toString}
        viewBox="-8 -8 24 24"
        focusable="false"
        role="presentation">
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
  @react.component
  let make = () => {
    <svg
      width=Spacing.sm_s
      height=Spacing.sm_s
      viewBox="0 0 8 5"
      fill="none"
      xmlns="http://www.w3.org/2000/svg">
      <path fillRule="evenodd" clipRule="evenodd" d="M0 0H8L4 5L0 0Z" fill="#333333" />
    </svg>
  }
}

module NoOptions = {
  let className = CssJs.style(. [
    display(#flex),
    justifyContent(#center),
    alignItems(#center),
    height(Spacing.sm_4->#px),
  ])

  @react.component
  let make = () => {
    <div className> <span> {"No Options"->React.string} </span> </div>
  }
}
