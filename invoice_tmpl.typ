// parameters that can be updated are stored in invoice_data.json
#let data = json("invoice_data.json")
#set document(
  author: data.payable.org,
  date: auto
)
#set page(
  "us-letter",
  fill: rgb("#F5F5EF")
)
#set text(font: "Helvetica Neue")
// -------------------------------
#show link: underline
// Invoice Parameters ----------------------------
#let invnumber = [#data.invnumber]
#let invperiod = [#data.invperiod]
#let desc = [#data.desc]
#let hours = data.hours
// Variables and Functions -----------------------
#let rate = data.rate
#let total = hours * rate
#let period = text(weight: "bold")[#invperiod]
#let inv = align(end)[
  #pad(top: -10pt, bottom: -5pt)[ID: \#00#invnumber]
]
// --------------------------------------------
// Set document title using invoice information
#set document(title: [
  #data.payable.org Contracting Invoice: \#00#invnumber - #invperiod - \$#total
])
// --------------------------------------------
#let today = {
  align(end)[#datetime.today().display()]
}
#let separator(width) = {
  line(length: 100%, stroke: width)
}
// BEGIN INVOICE ----------------------------------
#align(end)[
  #text(40pt, weight: "black")[INVOICE]
]
#pad(top: -30pt, bottom: 50pt)[
  #inv
  #today
]
#text(weight: "black")[BILLED TO:] \
#text()[
  #data.billto.org \
  #data.billto.ref
]

#pad(top: 50pt)[#period]

#pad(bottom: -10pt)[#separator(1pt)]

#table(
  columns: (60%, 13%, 13%, 13%),
  stroke: 0pt,
  inset: 10pt,
  gutter: 1pt,
  align: (left, center, center, right),
  table.header(
    [*Work*],
    [*Hours*],
    [*Rate*],
    [*Total*]
  )
)
#pad(top: -10pt, bottom: -5pt)[#separator(0.25pt)]
#table(
  columns: (60%, 13%, 13%, 13%),
  stroke: 0pt,
  inset: 12pt,
  gutter: 1pt,
  align: (left, center, center, right),
  table.header(
    [#desc],
    [#hours],
    [\$#rate],
    [\$#total]
  )
)
#pad(top: -10pt)[#separator(1pt)]
#align(end)[#text(16pt, weight: "black")[Total: \$#total]]
#pad(top: 50pt)[]
#align(end)[
  #text(weight: "black")[PAYABLE TO:] \
  #text()[
    #data.payable.org \
    #data.payable.ref
  ]
]