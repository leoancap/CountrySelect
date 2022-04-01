type t = {
  label: string,
  value: string,
}

let codec = Jzon.object2(
  ({label, value}) => (label, value),
  ((label, value)) => Ok({
    label: label,
    value: value,
  }),
  Jzon.field("label", Jzon.string),
  Jzon.field("value", Jzon.string),
)
