module List = {
  type rowRendererProps = {index: int, style: ReactDOM.style}

  @module("react-virtualized/dist/commonjs/List") @react.component
  external make: (
    ~rowRenderer: rowRendererProps => React.element,
    ~rowHeight: rowRendererProps => int,
    ~height: int,
    ~scrollToIndex: int=?,
    ~width: int,
    ~rowCount: int,
  ) => React.element = "default"
}

module AutoSizer = {
  type autoSizerProps = {width: int}
  @module("react-virtualized/dist/commonjs/AutoSizer") @react.component
  external make: (
    ~children: autoSizerProps => React.element,
    ~disableHeight: bool,
  ) => React.element = "default"
}
